FROM python:3.12-slim AS runtime
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1
WORKDIR /app
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        ca-certificates && \
    pip install --no-cache-dir kubernetes && \
    rm -rf /var/lib/apt/lists/*
ARG KUBECTL_VERSION=latest
RUN set -eux; \
    # determine arch
    ARCH="$(dpkg --print-architecture)"; \
    case "$ARCH" in \
        amd64)  KARCH="amd64" ;; \
        arm64)  KARCH="arm64" ;; \
        *) echo "Unsupported arch: $ARCH" >&2; exit 1 ;; \
    esac; \
    \
    if [ "$KUBECTL_VERSION" = "latest" ]; then \
      KVER="$(curl -L -s https://dl.k8s.io/release/stable.txt)"; \
    else \
      KVER="v${KUBECTL_VERSION}"; \
    fi; \
    curl -L "https://dl.k8s.io/release/${KVER}/bin/linux/${KARCH}/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -l https://raw.githubusercontent.com/shaman007/CAnitiser/refs/heads/main/ca-analyse.py -o /app/ca-analyse.py && \
    curl -l https://raw.githubusercontent.com/shaman007/CAnitiser/refs/heads/main/ca-nitiser-k8s.py -o ca-nitiser-k8s.py && \
    curl -l https://raw.githubusercontent.com/shaman007/CAnitiser/refs/heads/main/ca-report-html.py -o /app/ca-report-html.py && \
    curl -l https://raw.githubusercontent.com/shaman007/CAnitiser/refs/heads/main/push-report.py -o /app/push-report.py && \
    curl -l https://raw.githubusercontent.com/shaman007/CAnitiser/refs/heads/main/ca-report-html.py -o /app/ca-report-html.py
RUN useradd -r -u 10001 -g users scanner && \
    chown -R scanner:users /app
USER scanner
ENTRYPOINT ["python"]
CMD ["ca-nitiser-k8s.py", "--help"]
