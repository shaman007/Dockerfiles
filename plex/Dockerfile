FROM docker.io/library/debian:stable-slim
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates curl gnupg -y --no-install-recommends && \
    curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor -o /etc/apt/keyrings/plex.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" > /etc/apt/sources.list.d/plexmediaserver.list &&\
    DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install plexmediaserver -y --no-install-recommends &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN echo "plex:x:998:994::/var/lib/plexmediaserver:/usr/sbin/nologin" >> /etc/passwd && \
    echo "plex:x:994:" >> /etc/group && \
    echo "video:x:44:pi,plex" >> /etc/group
ENTRYPOINT ["/etc/run"]
