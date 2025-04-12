FROM docker.io/library/debian:stable-slim
RUN apt-get update && apt-getinstall redis-tools -y && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /etc/
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
