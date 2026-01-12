FROM cgr.dev/chainguard/wolfi-base:latest

# install tools at build time
RUN apk add --no-cache kubectl jq openssl ca-certificates bash

# run as nonroot at runtime
USER 65532:65532
ENTRYPOINT ["/bin/bash","-lc"]
