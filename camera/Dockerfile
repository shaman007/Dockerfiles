FROM docker.io/library/debian:stable-slim
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install ffmpeg lighttpd dumb-init && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \ 
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY 10-cgi.conf /etc/lighttpd/conf-enabled/10-cgi.conf
COPY webcamstream /var/www/cgi-bin/
RUN chmod +x /var/www/cgi-bin/webcamstream
COPY huser /etc/
COPY run /etc/
RUN chmod +x /etc/run
ENTRYPOINT ["dumb-init", "--", "/etc/service/run"]
