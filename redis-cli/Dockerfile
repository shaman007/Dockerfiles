FROM debian:latest
RUN apt update && apt install redis-tools -y && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup /etc/
ENTRYPOINT ["/etc/run"]
