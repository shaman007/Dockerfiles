FROM docker.io/library/debian:stable-slim
RUN apt update && apt install default-mysql-client -y && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /usr/local/bin
ENTRYPOINT ["/etc/run"]
