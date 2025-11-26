FROM ibm-semeru-runtimes:open-24-jre

#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install wget bzip2 curl dumb-init --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /photon
ADD https://github.com/komoot/photon/releases/download/0.6.0/photon-0.6.0.jar /photon/photon.jar
COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh
VOLUME /photon/photon_data
EXPOSE 2322

ENTRYPOINT ["dumb-init", "--", "/photon/entrypoint.sh"]
