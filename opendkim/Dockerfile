FROM debian:latest

RUN apt update
RUN apt -y install \
        bash \
        telnet \
        ca-certificates \
        procps \
        syslog-ng \
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
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
