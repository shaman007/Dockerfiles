FROM debian:stable-slim
RUN apt update && apt -y install php8.2-fpm \
                   default-dbus-session-bus \
                   gpm \
                   file \
                   php-pear \
                   libfido2-1 \
                   libqrencode4 \
                   libtss2-esys-3.0.2-0 \
                   libtss2-mu0 \
                   libtss2-rc0 \
                   php8.2-opcache \
                   php8.2-redis \
                   php8.2-mysql \
                   php8.2-apcu \
                   php8.2-imagick \
                   php8.2-zip \
                   php8.2-mbstring \
                   php8.2-gd \
                   php8.2-curl \
                   php8.2-intl \
                   php8.2-gmp \
                   php8.2-bcmath \
                   libfftw3-bin \
                   libfftw3-dev \
                   libgd-tools \
                   low-memory-monitor \
                   liblcms2-utils \
                   libmagickcore-6.q16-6-extra \
                   poppler-utils \
                   php8.2-cli \
                   php8.2-common \
                   sudo && apt-get remove -y git && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY run /etc/
COPY www.conf /etc/php/8.2/fpm/pool.d/
COPY opcache.ini /etc/php/8.2/mods-available
COPY apcu.ini /etc/php/8.2/mods-available
ENTRYPOINT ["/etc/run"]
