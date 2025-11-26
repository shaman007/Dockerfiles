FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get -y update &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
      mb2md \
      rspamd \
      dumb-init \
      ca-certificates \
      ssl-cert --no-install-recommends &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    mkdir /etc/service
COPY run /etc/service
RUN ln -sf /dev/stdout /var/log/mail.log
ENTRYPOINT ["dumb-init", "--", "/etc/service/run"]
