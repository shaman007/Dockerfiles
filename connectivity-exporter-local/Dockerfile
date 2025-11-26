FROM python:3.11-slim
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && apt-get install dumb-init -y --no-install-recommends &&\
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#hadolint ignore=DL3013
RUN pip install --no-cache-dir prometheus_client pyyaml flask
COPY run /etc
RUN chmod +x /etc/run
ADD https://raw.githubusercontent.com/shaman007/connectivity-exporter/refs/heads/main/check.py /app
COPY config.yaml /app
STOPSIGNAL SIGKILL
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
