FROM harbor.andreybondarenko.com/dockerhub/python:3.13-slim

ARG BASTIONCAM_REF=76a33ac43302631d7e80e97b35d605a644e53725

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends ca-certificates git && \
    git init /app && \
    git -C /app remote add origin https://github.com/shaman007/bastioncam.git && \
    git -C /app fetch --depth 1 origin "$BASTIONCAM_REF" && \
    git -C /app checkout --detach FETCH_HEAD && \
    pip install --no-cache-dir /app && \
    groupadd --gid 10001 bastioncam && \
    useradd --uid 10001 --gid 10001 --no-create-home --shell /usr/sbin/nologin bastioncam && \
    mkdir -p /data && \
    chown 10001:10001 /data && \
    apt-get purge --yes --auto-remove git && \
    rm -rf /var/lib/apt/lists/* /root/.cache /app/.git

WORKDIR /app
USER 10001:10001
VOLUME ["/data"]
EXPOSE 8787

ENTRYPOINT ["bastioncam"]
CMD ["--db", "/data/history.db", "serve", "--host", "0.0.0.0", "--port", "8787"]
