FROM quay.io/podman/stable:v5.8.4@sha256:e0cf8f68e0cf888e4d76cf23148dd83cc40fbfac43495a4794894fb4af0a0aeb

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
