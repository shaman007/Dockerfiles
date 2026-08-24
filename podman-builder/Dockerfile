FROM quay.io/podman/stable:v5.8.4@sha256:3b9f8367aa3e71b88914ea391f083fccc58c133d07b72f506e7104072ae4a6ed

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
