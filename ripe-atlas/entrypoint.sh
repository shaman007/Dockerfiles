#!/usr/bin/bash
set -Eeuo pipefail

install -d -o ripe-atlas -g ripe-atlas -m 0755 /etc/ripe-atlas
install -d -o ripe-atlas-measurement -g ripe-atlas -m 0775 \
  /run/ripe-atlas /run/ripe-atlas/pids /run/ripe-atlas/status
install -d -o ripe-atlas -g ripe-atlas -m 2775 \
  /var/spool/ripe-atlas \
  /var/spool/ripe-atlas/data \
  /var/spool/ripe-atlas/data/new \
  /var/spool/ripe-atlas/data/oneoff \
  /var/spool/ripe-atlas/data/out \
  /var/spool/ripe-atlas/data/out/ooq \
  /var/spool/ripe-atlas/data/out/ooq10 \
  /var/spool/ripe-atlas/crons \
  /var/spool/ripe-atlas/crons/main

if [[ ! -s /etc/ripe-atlas/mode ]]; then
  printf 'prod\n' > /etc/ripe-atlas/mode
fi

{
  printf 'RXTXRPT=%s\n' "$RXTXRPT"
  printf 'TELNETD_PORT=%s\n' "$TELNETD_PORT"
  printf 'HTTP_POST_PORT=%s\n' "$HTTP_POST_PORT"
} > /etc/ripe-atlas/config.txt

rm -f /etc/ripe-atlas/reg_servers.sh
chown -R ripe-atlas:ripe-atlas /etc/ripe-atlas /var/spool/ripe-atlas

exec setpriv \
  --reuid=ripe-atlas \
  --regid=ripe-atlas \
  --init-groups \
  --ambient-caps=+net_raw \
  --inh-caps=+net_raw \
  /usr/sbin/ripe-atlas
