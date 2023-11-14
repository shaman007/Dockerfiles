FROM debian:latest
RUN apt-get -y update && apt-get -y install \
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
  ssl-cert && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /etc/service
RUN useradd shaman007 -d /var/mail/boxes/shaman007
ADD run /etc/service
ENTRYPOINT ["/etc/service/run"]
