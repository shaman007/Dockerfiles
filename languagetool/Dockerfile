FROM debian:stable-slim
RUN apt update && apt-get upgrade -y && \
    apt-get install default-jre wget unzip && \
    wget https://languagetool.org/download/LanguageTool-stable.zip && \
    unzip LanguageTool-stable.zip && \
    mv LanguageTool* /languagetool && \
    apt -y remove wget unzip && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&
ENTRYPOINT ["java -cp /languagetool/languagetool-server.jar org.languagetool.server.HTTPServer --port 8081 --allow-origin"]
