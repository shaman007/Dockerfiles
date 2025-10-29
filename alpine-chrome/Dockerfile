FROM alpine:3.22

# Chromium + deps (nss needed), SwiftShader, fonts
RUN apk add --no-cache \
      chromium \
      nss \
      chromium-swiftshader \
      ttf-freefont \
      font-noto-emoji \
      font-wqy-zenhei \
      ca-certificates dumb-init && \
    update-ca-certificates

# Optional font tweaks (keep if you have it)
# COPY local.conf /etc/fonts/local.conf

# Non-root user + writable profile dir
RUN adduser -D -h /home/chrome chrome && \
    mkdir -p /data/profile /usr/src/app && \
    chown -R chrome:chrome /data /usr/src/app /home/chrome
USER chrome
WORKDIR /usr/src/app

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/ \
    # Silence dbus probes
    DBUS_SYSTEM_BUS_ADDRESS=disabled: \
    DBUS_SESSION_BUS_ADDRESS=disabled: \
    # Extra flags you may want to append
    CHROMIUM_FLAGS=""

EXPOSE 9222

ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/bin/sh","-lc", "\
exec \"$CHROME_BIN\" \
  --no-sandbox \
  --headless=new \
  --remote-debugging-address=0.0.0.0 \
  --remote-debugging-port=9222 \
  --user-data-dir=/data/profile \
  --no-first-run \
  --no-default-browser-check \
  --disable-gpu \
  --disable-gpu-compositing \
  --disable-vulkan \
  --use-angle=swiftshader \
  --use-gl=swiftshader \
  --disable-features=MediaRouter,Translate,OnDeviceModel,OptimizationHints,OptimizationGuideModelDownloading \
  $CHROMIUM_FLAGS \
"]
