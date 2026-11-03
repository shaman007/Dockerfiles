#!/bin/sh
# Adopt a legacy SQLite database without root, chown or editing the source file.
set -eu
source_path=${1:-/var/lib/crowdsec/data/crowdsec.db}
target_path=${2:-/var/lib/crowdsec/data/crowdsec-rootless.db}
for path in "$source_path" "$target_path"; do
    case "$path" in
        /*) ;;
        *) echo 'Database paths must be absolute' >&2; exit 1 ;;
    esac
    case "$path" in
        *[!a-zA-Z0-9_./-]*) echo 'Unsupported database path' >&2; exit 1 ;;
    esac
    test ! -L "$path" || { echo 'Refusing symlink database path' >&2; exit 1; }
done
test "$source_path" != "$target_path"
if [ -e "$target_path" ]; then
    test -f "$target_path" && test -s "$target_path" || {
        echo 'Existing rootless database is empty or invalid; refusing to hide the legacy database' >&2; exit 1;
    }
    test "$(stat -c %u "$target_path")" = "$(id -u)" || {
        echo 'Existing rootless database must belong to the runtime user' >&2; exit 1;
    }
    test "$(sqlite3 -readonly "$target_path" 'PRAGMA quick_check;')" = ok
    echo 'Existing rootless database verified; no migration needed'
    exit 0
fi
if [ ! -e "$source_path" ]; then
    echo 'Fresh volume; CrowdSec will create its rootless database'
    exit 0
fi
test -f "$source_path" && test -r "$source_path"
# The deployment uses Recreate and one LAPI replica: the old writer has stopped.
# SQLite's backup API includes committed WAL contents, unlike a plain file copy.
temporary=$(mktemp "${target_path%/*}/.rootless-database.XXXXXX")
trap 'rm -f "$temporary"' EXIT HUP INT TERM
sqlite3 -readonly "$source_path" ".backup '$temporary'"
test "$(sqlite3 -readonly "$temporary" 'PRAGMA quick_check;')" = ok
chmod 0600 "$temporary"
# Publish atomically without replacing any target created by another process.
ln "$temporary" "$target_path"
echo 'Legacy database copied and verified; original retained unchanged'
