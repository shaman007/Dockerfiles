FROM debian:latest
RUN apt-get -y update
RUN apt-get -y install \
  rspamd \
  ca-certificates \
  ssl-cert
# Clean up
RUN apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /etc/service
ADD run /etc/service
RUN ln -sf /dev/stdout /var/log/mail.log
ENTRYPOINT ["/etc/service/run"]
