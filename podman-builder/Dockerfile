FROM quay.io/podman/stable:v5.8.4@sha256:b0173238dceedf46a10d2c3a7bf9b217a85dce19706d2d9c80b01345839ae779

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
