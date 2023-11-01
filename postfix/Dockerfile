FROM debian:latest

RUN apt update
RUN apt install -y \
        bash \
        telnet \
        vim \
        procps \
        ca-certificates \
        postfix \
        postfix-pcre \
        sasl2-bin \
        postfix-lmdb \
        rsyslog \
        ssl-cert \
        postfix-policyd-spf-perl
COPY service/* /etc/service/
COPY etc/postfix/main.cf /etc/postfix/main.cf
#COPY usr/sbin/runit_bootstrap /usr/sbin/runit_bootstrap
COPY etc/aliases /etc/postfix
RUN useradd shaman007
RUN ln -sf /dev/stdout /var/log/mail.log
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
