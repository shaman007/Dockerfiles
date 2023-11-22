FROM debian:stable-slim
RUN apt update && apt-get upgrade -y && \
    apt-get -y install default-jre wget unzip && \
    wget https://languagetool.org/download/LanguageTool-stable.zip && \
    unzip LanguageTool-stable.zip && \
    rm LanguageTool-stable.zip && \
    mv -r LanguageTool-6.3 /languagetool && \
    apt -y remove wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
ENTRYPOINT ["/etc/run"]
