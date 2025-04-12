FROM debian:stable-slim
RUN apt update && apt-get upgrade -y && \
    apt-get -y install clamav clamav-daemon dumb-init && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav && \
    mkdir /usr/local/share/clamav && \
    chown -R clamav:clamav /var/lib/clamav /usr/local/share/clamav /etc/clamav
RUN freshclam
VOLUME /var/lib/clamav
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
