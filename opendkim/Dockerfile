FROM debian:latest

RUN apt update
RUN apt -y install \
        ca-certificates \
        rsyslog \
        opendkim \
        opendkim-tools
COPY run /etc/service/
RUN mkdir /etc/opendkim_init
RUN mkdir /etc/opendkim
COPY opendkim.conf /etc/
COPY signingtable /etc/opendkim_init
COPY keytable /etc/opendkim_init
COPY mail.private  /etc/opendkim_init
COPY mail.txt  /etc/opendkim_init
COPY trustedhosts  /etc/opendkim_init
# Clean up
RUN apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
