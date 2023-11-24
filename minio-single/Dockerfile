FROM debian:stable-slim
RUN apt update && apt install wget -y
RUN wget https://dl.min.io/server/minio/release/linux-arm64/archive/minio.deb && dpkg -i minio.deb && rm minio.deb
RUN wget https://dl.min.io/client/mc/release/linux-arm64/mc.deb && dpkg -i mc.deb && rm mc.deb
RUN apt-get -y remove wget && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
ENTRYPOINT ["/etc/run"]
