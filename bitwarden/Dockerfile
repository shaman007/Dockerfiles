# renovate: datasource=docker depName=bitwarden/lite registryUrl=https://ghcr.io
FROM harbor.andreybondarenko.com/github/bitwarden/lite:2026.8.0

LABEL org.opencontainers.image.source="https://github.com/bitwarden/server" \
      org.opencontainers.image.version="2026.7.2" \
      org.opencontainers.image.licenses="AGPL-3.0-only AND LicenseRef-Bitwarden-1.0"

USER root

# Preserve the complete upstream dual-license notice in every redistributed
# image. Files are pinned to the same upstream release as the base image.
ADD --chmod=0444 https://raw.githubusercontent.com/bitwarden/server/v2026.7.2/LICENSE.txt /usr/share/licenses/bitwarden/LICENSE.txt
ADD --chmod=0444 https://raw.githubusercontent.com/bitwarden/server/v2026.7.2/LICENSE_AGPL.txt /usr/share/licenses/bitwarden/LICENSE_AGPL.txt
ADD --chmod=0444 https://raw.githubusercontent.com/bitwarden/server/v2026.7.2/LICENSE_BITWARDEN.txt /usr/share/licenses/bitwarden/LICENSE_BITWARDEN.txt

# The upstream entrypoint creates this account, changes ownership throughout the
# image, and edits Supervisor configuration every time the container starts.
# Create the fixed runtime account and immutable defaults while building instead.
RUN set -eux; \
    addgroup -g 1000 bitwarden; \
    adduser -D -H -u 1000 -G bitwarden bitwarden; \
    mkdir -p /usr/local/share/bitwarden-supervisor /usr/local/share/bitwarden-nginx; \
    cp -a /etc/supervisor.d/. /usr/local/share/bitwarden-supervisor/; \
    cp -a /etc/nginx/http.d/default.conf /usr/local/share/bitwarden-nginx/; \
    sed -i '/^\[supervisord\]/a pidfile=/run/supervisord.pid' /etc/supervisor/supervisord.conf; \
    chown -R 1000:1000 \
      /app \
      /etc/bitwarden \
      /etc/nginx/http.d \
      /etc/supervisor \
      /etc/supervisor.d \
      /var/lib/nginx \
      /var/log \
      /var/run/nginx \
      /run \
      /usr/local/share/bitwarden-supervisor \
      /usr/local/share/bitwarden-nginx

COPY entrypoint.sh prepare-runtime.sh /usr/local/bin/
RUN chmod 0555 /usr/local/bin/entrypoint.sh /usr/local/bin/prepare-runtime.sh

USER 1000:1000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
