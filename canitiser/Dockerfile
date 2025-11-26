FROM python:3.12-slim AS runtime
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*
ARG KUBECTL_VERSION=latest
RUN set -eux; \
    if [ "$KUBECTL_VERSION" = "latest" ]; then \
      KVER="$(curl -L -s https://dl.k8s.io/release/stable.txt)"; \
    else \
      KVER="v${KUBECTL_VERSION}"; \
    fi; \
    curl -L "https://dl.k8s.io/release/${KVER}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -l https://github.com/shaman007/CAnitiser/blob/af98f7149963db3c8f8af4fa80eb25f27047f999/ca-analyse.py -o /app/ca-analyse.py && \
    curl -l https://github.com/shaman007/CAnitiser/blob/af98f7149963db3c8f8af4fa80eb25f27047f999/ca-nitiser.py -o ca-nitiser.py && \
    curl -l https://github.com/shaman007/CAnitiser/blob/af98f7149963db3c8f8af4fa80eb25f27047f999/ca-report-html.py -o /app/ca-report-html.py && \
    curl -l https://github.com/shaman007/CAnitiser/blob/af98f7149963db3c8f8af4fa80eb25f27047f999/ca-report-html.py -o /app/ca-report-html.py
RUN useradd -r -u 10001 -g users scanner && \
    chown -R scanner:users /app
USER scanner
ENTRYPOINT ["python"]
CMD ["ca-nitiser.py", "--help"]
