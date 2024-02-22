FROM debian:stable-slim
RUN apt update && apt install ca-certificates curl gnupg -y
RUN curl https://downloads.plex.tv/plex-keys/PlexSign.key | gpg --dearmor -o /etc/apt/keyrings/plex.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/plex.gpg] https://downloads.plex.tv/repo/deb public main" > /etc/apt/sources.list.d/plexmediaserver.list
RUN apt update && apt install plexmediaserver -y && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
RUN echo "plex:x:998:994::/var/lib/plexmediaserver:/usr/sbin/nologin" >> /etc/passwd
RUN echo "plex:x:994:" >> /etc/group
RUN echo "video:x:44:pi,plex" >> /etc/group
ENTRYPOINT ["/etc/run"]
