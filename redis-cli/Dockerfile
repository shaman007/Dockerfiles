FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install redis-tools -y --no-install-recommends &&\
    DEBIAN_FRONTEND=noninteractive apt-get remove -y git &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /etc/
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
