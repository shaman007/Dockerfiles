FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install rsyslog -y --no-install-recommends &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#hadolint ignore=SC2028
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ \n\
*. * @127.0.0.1:514' > /etc/rsyslog.conf
ENTRYPOINT ["rsyslogd", "-n"]
