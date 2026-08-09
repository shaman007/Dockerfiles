FROM harbor.andreybondarenko.com/dockerhub/ibm-semeru-runtimes:open-26-jre

#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install wget bzip2 curl dumb-init --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /photon
ARG PHOTON_VERSION=1.2.1
RUN wget --progress=dot:giga \
    "https://github.com/komoot/photon/releases/download/${PHOTON_VERSION}/photon-${PHOTON_VERSION}.jar" \
    -O /photon/photon.jar
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
VOLUME /photon/photon_data
EXPOSE 2322

ENTRYPOINT ["dumb-init", "--", "/photon/entrypoint.sh"]
