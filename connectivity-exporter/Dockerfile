FROM python:3.11-slim
RUN pip install --no-cache-dir prometheus_client pyyaml
COPY run /etc
WORKDIR /app
ADD https://raw.githubusercontent.com/shaman007/connectivity-exporter/refs/heads/main/connectivity-exporter.py .
COPY config.yaml .
STOPSIGNAL SIGKILL
ENTRYPOINT ["dumb-init", "--", "/etc/run"]