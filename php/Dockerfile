FROM docker.io/library/debian:stable-slim
RUN apt-get update && apt-get -y install php-fpm \
                   default-dbus-session-bus \
                   gpm \
                   file \
                   php-pear \
                   libfido2-1 \
                   libqrencode4 \
                   libtss2-esys-3.0.2-0 \
                   libtss2-mu0 \
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
                   libmagickcore-6.q16-6-extra \
                   poppler-utils \
                   php-cli \
                   php-common \
                   ffmpeg \
                   dumb-init \
                   sudo && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN ln -sf /proc/1/fd/1 /var/log/php8.2-fpm.log
COPY run /etc/
RUN  mkdir -p /etc/php/8.2/fpm/pool.d/
COPY php.ini /etc/php/8.2/fpm/pool.d/
RUN  mkdir -p /etc/php/8.2/mods-available
COPY apcu.ini /etc/php/8.2/mods-available
ENTRYPOINT ["dumb-init", "--", "/etc/run"]
