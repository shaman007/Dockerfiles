FROM debian:stable-slim
RUN apt update && apt install wget -y && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN wget https://dl.min.io/server/minio/release/linux-arm64/archive/minio_20231120224007.0.0_arm64.deb -O minio.deb && dpkg -i minio.deb && rm minio.deb
COPY run /etc/
ENTRYPOINT ["/etc/run"]
