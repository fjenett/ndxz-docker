FROM cespi/php-5.3:modules-apache

# Install mysql_config ...
RUN apk update \
    && apk add --virtual build-deps gcc musl-dev \
    && apk add --no-cache mariadb-dev

# ... and then mysqli
RUN docker-php-ext-install mysqli

RUN apk update \
    && apk upgrade \
    && apk add --no-cache \
        freetype-dev \
        libpng-dev \
        jpeg-dev \
        libjpeg-turbo-dev \
        libwebp-dev

RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/lib/ \
        --with-png-dir=/usr/lib/ \
        --with-jpeg-dir=/usr/lib/ \
        # GD is too old?
        # --with-webp-dir=/usr/lib/ \
        --with-gd

RUN NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NUMPROC} gd

# Enable mod_rewrite, htaccess
COPY config/*.conf /etc/apache2/conf.d/

# File sizes, etc.
COPY config/*.ini /usr/local/etc/php/conf.d/