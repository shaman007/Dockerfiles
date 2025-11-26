#!/usr/bin/env bash
set -uo pipefail

# Find files like service_name/Dockerfile
mapfile -t FILES < <(find . -type f -name Dockerfile)

if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No Dockerfiles found."
    exit 0
fi

status=0

for f in "${FILES[@]}"; do
    echo "Linting $f"
    # run hadolint, but don't abort the script on failure
    if ! docker run --rm -i hadolint/hadolint hadolint - < "$f"; then
        status=1
    fi
done

exit "$status"
