FROM docker.io/library/alpine:3.24.1 AS download

ARG TARGETARCH
ARG OONIPROBE_VERSION=3.30.0

RUN apk add --no-cache ca-certificates \
    && case "$TARGETARCH" in \
    amd64) checksum="53099f967a7ab0374c5c8c1c2c04ba028f09ff737b369caf6bcf10c34541fcf3" ;; \
    arm64) checksum="e4831e12d5ba4c19d4b3a0eb6277826e2f3a898b9bf1f4cba1de58eebf70dcdd" ;; \
    *) echo "unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
    esac \
    && wget -O /ooniprobe "https://github.com/ooni/probe-cli/releases/download/v${OONIPROBE_VERSION}/ooniprobe-linux-${TARGETARCH}" \
    && echo "${checksum}  /ooniprobe" | sha256sum -c - \
    && chmod 0555 /ooniprobe

FROM scratch

COPY --from=download /ooniprobe /usr/local/bin/ooniprobe
COPY --from=download /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENV HOME=/data \
    SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

WORKDIR /data
USER 65532:65532

ENTRYPOINT ["/usr/local/bin/ooniprobe"]
CMD ["version"]
