FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ca-certificates \
        postfix \
        postfix-pcre \
        sasl2-bin \
        postfix-lmdb \
        dumb-init \
        ssl-cert \
        postfix-policyd-spf-perl --no-install-recommends && \
        apt-get remove -y git &&\
        DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
        DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
        ln -sf /proc/1/fd/1 /var/log/mail.log
COPY run /etc/service/
COPY etc/postfix/main.cf /etc/postfix/main.cf
COPY etc/aliases /etc/postfix
RUN useradd shaman007 && newaliases
STOPSIGNAL SIGKILL
ENTRYPOINT ["dumb-init", "--", "/etc/service/run"]
