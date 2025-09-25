FROM docker.io/library/debian:stable-slim
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates curl gnupg -y
RUN curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor -o /etc/apt/keyrings/plex.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" > /etc/apt/sources.list.d/plexmediaserver.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install plexmediaserver -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && apt-get clean &&\
    DEBIAN_FRONTEND=noninteractive rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN echo "plex:x:998:994::/var/lib/plexmediaserver:/usr/sbin/nologin" >> /etc/passwd
RUN echo "plex:x:994:" >> /etc/group
RUN echo "video:x:44:pi,plex" >> /etc/group
ENTRYPOINT ["/etc/run"]
