FROM debian:latest
RUN apt-get -y update 
RUN apt-get -y install \
  procps \
  vim \
  telnet \
  dovecot-core \
  dovecot-gssapi \
  dovecot-imapd \
  dovecot-ldap \
  dovecot-lmtpd \
  dovecot-auth-lua \
  dovecot-managesieved \
  dovecot-mysql \
  dovecot-pgsql \
  dovecot-pop3d \
  dovecot-sieve \
  dovecot-solr \
  dovecot-sqlite \
  dovecot-submissiond \
  ca-certificates \
  ssl-cert

RUN apt-get -y install syslog-ng
RUN mkdir /etc/service
RUN useradd shaman007
ADD run /etc/service
RUN ln -sf /dev/stdout /var/log/mail.log
ENTRYPOINT ["/etc/service/run"]
