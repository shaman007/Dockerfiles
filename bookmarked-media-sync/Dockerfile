FROM harbor.andreybondarenko.com/dockerhub/library/node:26-alpine@sha256:6bd9ab43c0ec0190ca7b2d193906cb8b7edf6e7f4afa43ddeccd6452710bffb5

# Keep the existing job's utilities in the image's lower layer. Installing them
# at startup makes legitimate executions look like dropped binaries to Falco.
# hadolint ignore=DL3018
RUN apk add --no-cache ca-certificates coreutils curl jq kubectl \
    && npm install --global --no-audit --no-fund @immich/cli@3.0.2 \
    && npm cache clean --force \
    && node --version \
    && immich --version \
    && kubectl version --client=true \
    && curl --version \
    && jq --version

WORKDIR /work
