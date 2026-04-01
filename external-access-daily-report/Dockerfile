FROM harbor.andreybondarenko.com/dockerhub/alpine:3.23

RUN apk add --no-cache \
    ca-certificates \
    python3 \
    tzdata

WORKDIR /app

COPY external-access-daily-report.py /app/external-access-daily-report.py

CMD ["python3", "/app/external-access-daily-report.py"]
