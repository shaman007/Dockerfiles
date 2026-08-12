# renovate: datasource=docker depName=freikin/dawarich
FROM harbor.andreybondarenko.com/dockerhub/freikin/dawarich:1.12.0

USER root

# The upstream image creates and switches to a user at runtime, after
# recursively chowning application code. Prepare the fixed service account and
# image-owned files at build time instead, so the workload can use a read-only
# root filesystem.
RUN set -eux; \
    if ! getent group 1000 >/dev/null; then groupadd --gid 1000 dawarich; fi; \
    if ! getent passwd 1000 >/dev/null; then \
      useradd --uid 1000 --gid 1000 --home-dir /var/app --shell /usr/sbin/nologin dawarich; \
    fi; \
    chown --recursive 1000:1000 /var/app

COPY --chown=1000:1000 web-entrypoint.sh sidekiq-entrypoint.sh /usr/local/bin/
COPY --chown=1000:1000 read-only-rootfs.rb /var/app/config/initializers/
RUN chmod 0555 /usr/local/bin/web-entrypoint.sh /usr/local/bin/sidekiq-entrypoint.sh

USER 1000:1000
