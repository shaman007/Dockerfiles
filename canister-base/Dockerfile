FROM alpine:3.22

RUN apk add --no-cache \
      ca-certificates \
      skopeo \
      umoci \
      openssl \
      bash \
      jq

WORKDIR /work
CMD ["sh", "-c", "echo scanner ready; sleep 3600"]
