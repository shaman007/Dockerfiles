FROM docker.io/library/debian:stable-slim
RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install default-jre wget dumb-init unzip
#Have to split layers, so my registry can consume them
RUN wget https://languagetool.org/download/LanguageTool-stable.zip
RUN unzip LanguageTool-stable.zip && \
    rm LanguageTool-stable.zip && \
    mv LanguageTool-6.6 /languagetool
RUN apt-get -y remove wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
