FROM quay.io/podman/stable:v5.8.4@sha256:d7ea7a1bb943eb1409a2eccf1fca04e2e2150f5385fb14b7218ffe375544a6fd

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
