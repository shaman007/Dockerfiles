FROM alpine:3.17

RUN apk add --no-cache \
        bash \
        inetutils-telnet \
        ca-certificates \
        libsasl \
        mailx \
        postfix \
        rsyslog \
        runit \
        bind-tools \
        postfix-policyd-spf-perl
COPY service/* /etc/service/
COPY etc/postfix/main.cf /etc/postfix/main.cf
COPY usr/sbin/runit_bootstrap /usr/sbin/runit_bootstrap
COPY etc/aliases /etc/postfix
RUN adduser --disabled-password shaman007
RUN ln -sf /dev/stdout /var/log/mail.log
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
