FROM docker.io/library/debian:stable-slim
RUN apt-get update && apt-get install postgresql-client-15 dumb-init -y && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /usr/local/bin
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
