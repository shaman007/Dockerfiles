FROM docker.io/library/debian:stable-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install default-jre wget dumb-init unzip --no-install-recommends && \
    wget --progress=dot:giga https://languagetool.org/download/LanguageTool-stable.zip && \
    unzip LanguageTool-stable.zip && \
    rm LanguageTool-stable.zip && \
    mv LanguageTool-6.6 /languagetool && \
    DEBIAN_FRONTEND=noninteractive apt-get -y remove wget unzip && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
