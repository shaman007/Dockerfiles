FROM quay.io/podman/stable:v5.8.4@sha256:fc53a67d92a55ce83e3e5972555675c82bda54c1735c44db3c64f503a9529f15

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
