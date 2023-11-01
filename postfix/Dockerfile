FROM debian:latest

RUN apt update
RUN apt install -y \
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
COPY etc/aliases /etc/postfix
RUN useradd shaman007
RUN ln -sf /dev/stdout /var/log/mail.log
# Clean up
RUN apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
