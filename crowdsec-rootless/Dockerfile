FROM docker.io/crowdsecurity/crowdsec:v1.8.2@sha256:65b74942f7e7ed5c60fde4ac15fc4ba715904c398c8b16dd451f4907d90347d4

USER root
RUN set -eux; \
    apk add --no-cache sqlite; \
    addgroup -g 1000 crowdsec; \
    adduser -D -H -u 1000 -G crowdsec -h /var/lib/crowdsec crowdsec; \
    mkdir -p /etc/crowdsec_data /var/lib/crowdsec/data; \
    chown -R 1000:1000 /staging/etc/crowdsec /staging/var/lib/crowdsec /var/lib/crowdsec /etc/crowdsec_data; \
    chgrp 1000 /etc; \
    chmod 1775 /etc

# The chart creates /etc/crowdsec at startup. Group write permits that one new
# entry; the sticky bit protects existing root-owned /etc entries from removal.
# Root-owned /etc files retain their original ownership and permissions.
COPY --chmod=0555 prepare-database.sh /usr/local/bin/crowdsec-rootless-prepare-database
ENV HOME=/var/lib/crowdsec
USER 1000:1000
