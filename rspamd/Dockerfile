FROM debian:latest
RUN apt-get -y update 
RUN apt-get -y install \
  procps \
  vim \
  telnet \
  rspamd \
  ca-certificates \
  ssl-cert

RUN apt-get -y install syslog-ng
RUN mkdir /etc/service
ADD run /etc/service
RUN ln -sf /dev/stdout /var/log/mail.log
ENTRYPOINT ["/etc/service/run"]
