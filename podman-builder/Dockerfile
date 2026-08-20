FROM quay.io/podman/stable:v5.8.4@sha256:312a77be1ff51c7a124da1ffd0456802f11aeb338319b3b8b9d37358f9903fc7

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
