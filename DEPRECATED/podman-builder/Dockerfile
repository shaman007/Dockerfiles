# Deprecated: the CronJob now uses upstream Podman and git-sync directly.
FROM quay.io/podman/stable:v5.8.4

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
