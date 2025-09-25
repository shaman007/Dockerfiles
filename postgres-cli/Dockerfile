FROM docker.io/library/debian:stable-slim
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install postgresql-client-17 dumb-init -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get remove -y git &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /usr/local/bin
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
