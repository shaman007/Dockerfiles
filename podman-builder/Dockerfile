FROM harbor.andreybondarenko.com/quay/podman/stable:v5.8.2@sha256:663e0dbf407987b7db3f20d3588c283a8228db17b282d2029a482d4d47e36964

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
