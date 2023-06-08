FROM php:5.3-apache

# Fix: Syntax error on line 3 of /etc/apache2/apache2.conf:
# Invalid Mutex directory in argument file:/var/lock/apache2
# https://github.com/docker-library/php/issues/97
RUN sed -i 's/^Mutex.*/#&/g; s/^PidFile.*/#&/g' "/etc/apache2/apache2.conf"

# Enable mod_rewrite
RUN a2enmod rewrite

