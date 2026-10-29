FROM harbor.andreybondarenko.com/dockerhub/debian:trixie-slim
# DSA-6574-1: CVE-2026-109618 and CVE-2026-109619.
ARG PHP_MIN_VERSION=8.4.27-1~deb13u1
#hadolint ignore=DL3008
RUN DEBIAN_FRONTEND=noninteractive apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade &&\
    DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install -- \
                   php-fpm \
                   default-dbus-session-bus \
                   file \
                   php-pear \
                   libfido2-1 \
                   libqrencode4 \
                   libtss2-esys-3.0.2-0 \
                   libtss2-mu-4.0.1-0t64 \
                   libtss2-rc0 \
                   php-opcache \
                   php-redis \
                   php-mysql \
                   php-apcu \
                   php-imagick \
                   php-zip \
                   php-mbstring \
                   php-gd \
                   php-curl \
                   php-intl \
                   php-gmp \
                   php-bcmath \
                   libfftw3-bin \
                   libfftw3-dev \
                   libgd-tools \
                   low-memory-monitor \
                   liblcms2-utils \
                   libmagickcore-7.q16-10-extra \
                   poppler-utils \
                   php-cli \
                   php-common \
                   ffmpeg \
                   sudo \
                   openssl \
                   ca-certificates \
                   dumb-init \
                   libimage-exiftool-perl && \
                   dpkg --compare-versions "$(dpkg-query -W -f='${Version}' php8.4-fpm)" ge "$PHP_MIN_VERSION" && \
                   dpkg --compare-versions "$(dpkg-query -W -f='${Version}' php8.4-cli)" ge "$PHP_MIN_VERSION" && \
                   DEBIAN_FRONTEND=noninteractive apt-get remove -y git &&\
                   DEBIAN_FRONTEND=noninteractive apt-get autoremove -y &&\
                   DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
                   ln -sf /proc/1/fd/1 /var/log/php8.4-fpm.log &&\
                   usermod -aG clock www-data
COPY run /etc/
RUN chmod 0555 /etc/run && \
    mkdir -p /etc/php/8.4/fpm/pool.d/
COPY php.ini /etc/php/8.4/fpm/pool.d/
RUN  mkdir -p /etc/php/8.4/mods-available
COPY apcu.ini /etc/php/8.4/mods-available
RUN chmod 0644 /etc/php/8.4/mods-available/apcu.ini
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
