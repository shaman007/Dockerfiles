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

if [[ "$REGISTRATION_IPV4_ONLY" == "yes" ]]; then
  # Atlas derives the public IPv4 address from an IPv4 registration connection.
  # Repeat the two official IPv4 endpoints because reginit expects six choices.
  # This affects only the control bootstrap; IPv6 measurements remain available.
  cat > /etc/ripe-atlas/reg_servers.sh <<'EOF'
REG_1_HOST=193.0.19.75
REG_2_HOST=193.0.19.76
REG_3_HOST=193.0.19.75
REG_4_HOST=193.0.19.76
REG_5_HOST=193.0.19.75
REG_6_HOST=193.0.19.76
EOF
else
  rm -f /etc/ripe-atlas/reg_servers.sh
fi
chown -R ripe-atlas:ripe-atlas /etc/ripe-atlas /var/spool/ripe-atlas

exec setpriv \
  --reuid=ripe-atlas \
  --regid=ripe-atlas \
  --init-groups \
  --ambient-caps=+net_raw \
  --inh-caps=+net_raw \
  /usr/sbin/ripe-atlas
