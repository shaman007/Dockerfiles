FROM docker.io/library/oraclelinux:9-slim@sha256:33bcb689f7c8e6bd15bcee9a253538bc0b7cafeadb8b1a9d6ac90669c4497ce3

ARG RIPE_ATLAS_REPO_VERSION=1.6-1
ARG RIPE_ATLAS_VERSION=5130-1.el9
ARG TINI_VERSION=0.19.0

RUN set -eux; \
    repo_package="ripe-atlas-repo-${RIPE_ATLAS_REPO_VERSION}.el9.noarch.rpm"; \
    curl --fail --location --remote-name \
      "https://ftp.ripe.net/ripe/atlas/software-probe/el9/noarch/${repo_package}"; \
    curl --fail --location --remote-name \
      https://github.com/RIPE-NCC/ripe-atlas-software-probe/releases/latest/download/CHECKSUMS; \
    grep -Fq "$(sha256sum "$repo_package")" CHECKSUMS; \
    rpm --upgrade --verbose --hash "$repo_package"; \
    rm -f "$repo_package" CHECKSUMS; \
    microdnf install -y \
      "ripe-atlas-probe-${RIPE_ATLAS_VERSION}" \
      shadow-utils \
      util-linux; \
    microdnf clean all; \
    rm -rf /var/cache/dnf /var/log/dnf* /etc/ripe-atlas/probe_key*; \
    install -d -o ripe-atlas -g ripe-atlas -m 0755 /etc/ripe-atlas; \
    install -d -o ripe-atlas-measurement -g ripe-atlas -m 0775 \
      /run/ripe-atlas /run/ripe-atlas/pids /run/ripe-atlas/status; \
    install -d -o ripe-atlas -g ripe-atlas -m 2775 /var/spool/ripe-atlas

ADD --checksum=sha256:c5b0666b4cb676901f90dfcb37106783c5fe2077b04590973b885950611b30ee \
    --chmod=0555 \
    https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-static-amd64 \
    /usr/bin/tini
COPY --chmod=0555 entrypoint.sh /usr/local/bin/ripe-atlas-entrypoint

ENV HOME=/var/spool/ripe-atlas \
    RXTXRPT=no \
    REGISTRATION_IPV4_ONLY=yes \
    TELNETD_PORT=2023 \
    HTTP_POST_PORT=8080

WORKDIR /var/spool/ripe-atlas
VOLUME ["/etc/ripe-atlas", "/run/ripe-atlas", "/var/spool/ripe-atlas"]

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/ripe-atlas-entrypoint"]
