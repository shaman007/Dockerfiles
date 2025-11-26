FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install clamav clamav-daemon dumb-init --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav && \
    mkdir /usr/local/share/clamav && \
    chown -R clamav:clamav /var/lib/clamav /usr/local/share/clamav /etc/clamav
RUN freshclam
VOLUME /var/lib/clamav
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
