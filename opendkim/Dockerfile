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
RUN mkdir /etc/opendkim
COPY opendkim.conf /etc/
COPY signingtable /etc/opendkim
COPY keytable /etc/opendkim
COPY mail.private  /etc/opendkim
COPY mail.txt  /etc/opendkim
COPY trustedhosts  /etc/opendkim
RUN chmod 700 /etc/opendkim
RUN chmod 400 /etc/opendkim/mail.private
RUN chmod 400 /etc/opendkim/mail.txt
RUN chown -R opendkim.opendkim /etc/opendkim
#RUN ln -sf /dev/stdout /var/log/mail.log
STOPSIGNAL SIGKILL
ENTRYPOINT ["/etc/service/run"]
