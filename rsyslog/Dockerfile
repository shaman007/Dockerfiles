FROM debian:latest
RUN apt update && apt install rsyslog -y && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ \n\
*. * @127.0.0.1:514' > /etc/rsyslog.conf
ENTRYPOINT ["rsyslogd", "-n"]
