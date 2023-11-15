FROM debian:latest
RUN apt update && apt-get upgrade -y && apt-get install xxd -y && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY backup.sh /usr/local/bin
ENTRYPOINT ["/etc/run"]
