FROM debian:stable-slim
RUN apt update && apt-get upgrade -y && \
    apt-get -y install clamav clamav-daemon && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN chown -R clamav:clamav /var/lib/clamav/
RUN freshclam
VOLUME /var/lib/clamav
ENTRYPOINT ["/etc/run"]
