FROM debian:stable-slim
RUN apt-get -y update && apt-get -y install \
  mb2md \
  rspamd \
  ca-certificates \
  ssl-cert && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /etc/service
COPY run /etc/service
RUN ln -sf /dev/stdout /var/log/mail.log
ENTRYPOINT ["/etc/service/run"]
