FROM debian:stable-slim
RUN apt update && apt -y install ffmpeg lighttpd && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY 10-cgi.conf /etc/lighttpd/conf-available/10-cgi.conf
COPY webcamstream /var/www/cgi-bin/
RUN chmod +x /var/www/cgi-bin/webcamstream
COPY run /etc/
ENTRYPOINT ["/etc/run"]