FROM php:7.3-apache

# Fix: Syntax error on line 3 of /etc/apache2/apache2.conf:
# Invalid Mutex directory in argument file:/var/lock/apache2
# https://github.com/docker-library/php/issues/97
# RUN sed -i 's/^Mutex.*/#&/g; s/^PidFile.*/#&/g' "/etc/apache2/apache2.conf"

# Enable mod_rewrite
RUN a2enmod rewrite

# Fix deprecated sources
# COPY sources.list /etc/apt/sources.list

# Install PHP GD
# RUN apt-get update && apt-get install -y php5-gd

RUN apt-get update && apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-webp-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib-dir \
    --with-xpm-dir \
    --with-freetype-dir
 #    --enable-gd-native-ttf

RUN docker-php-ext-install mysqli gd