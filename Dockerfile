FROM cespi/php-5.3:modules-apache

# Install mysql_config ...
RUN apk update \
    && apk add --virtual build-deps gcc musl-dev \
    && apk add --no-cache mariadb-dev

# ... and then mysqli
RUN docker-php-ext-install mysqli

# Enable mod_rewrite, htaccess
COPY config/*.conf /etc/apache2/conf.d/