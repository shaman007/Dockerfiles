FROM debian:stable-slim

RUN apt update && apt install -y \
        ca-certificates \
        postfix \
        postfix-pcre \
        sasl2-bin \
        postfix-lmdb \
        ssl-cert \
        postfix-policyd-spf-perl && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ln -sf /proc/1/fd/1 /var/log/mail.log
COPY run /etc/service/
COPY etc/postfix/main.cf /etc/postfix/main.cf
COPY etc/aliases /etc/postfix
RUN useradd shaman007
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
