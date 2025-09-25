FROM docker.io/library/debian:stable-slim

# Install necessary dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget dumb-init

# Set architecture variable
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio.deb && \
        dpkg -i minio.deb && rm minio.deb; \
    elif [ "$ARCH" = "arm64" ]; then \
        wget https://dl.min.io/server/minio/release/linux-arm64/archive/minio.deb && \
        dpkg -i minio.deb && rm minio.deb; \
    fi

# Install MinIO client
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then \
        wget https://dl.min.io/client/mc/release/linux-amd64/mc.deb && \
        dpkg -i mc.deb && rm mc.deb; \
    elif [ "$ARCH" = "arm64" ]; then \
        wget https://dl.min.io/client/mc/release/linux-arm64/mc.deb && \
        dpkg -i mc.deb && rm mc.deb; \
    fi

# Clean up unnecessary files
RUN DEBIAN_FRONTEND=noninteractive apt-get -y remove wget &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean &&\
    DEBIAN_FRONTEND=noninteractive rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy your custom script to the container
COPY run /etc/

# Set the ENTRYPOINT
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
