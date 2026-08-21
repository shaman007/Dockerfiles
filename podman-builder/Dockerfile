FROM quay.io/podman/stable:v5.8.4@sha256:8923deffca4caa8338b5dd4f553a86736f2aab424a4743827fccce632fecd750

# hadolint ignore=DL3041
RUN dnf install --assumeyes --setopt=install_weak_deps=False git-core && \
    dnf clean all

COPY run /usr/local/bin/nightly-build
RUN chmod 0555 /usr/local/bin/nightly-build

ENTRYPOINT ["/usr/local/bin/nightly-build"]
