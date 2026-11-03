FROM docker.io/crowdsecurity/crowdsec:v1.8.1@sha256:0f2523fa61ef507f15d953045cface490cc880670c62f2755ced17524107f71a

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
