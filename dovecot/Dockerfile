FROM docker.io/library/debian:stable-slim
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
  vim-tiny \
  ca-certificates \
  dumb-init \
  ssl-cert && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ln -sf /proc/1/fd/1 /var/log/mail.log
RUN mkdir /etc/service
RUN useradd shaman007 -d /var/mail/boxes/shaman007
COPY run /etc/service
ENTRYPOINT ["dumb-init", "--", "/etc/service/run"]
