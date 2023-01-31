FROM php:8.1-apache
RUN apt-get update && apt-get install -y wget \
  	libfreetype6-dev \
        libjpeg62-turbo-dev  libc-client-dev libkrb5-dev \
        libpng-dev  libldap2-dev libxml2-dev libbz2-dev libzip-dev graphviz  && rm -rf /var/cache/apt

RUN docker-php-ext-configure gd  && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) ldap mysqli soap

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap

# Install opcache 
RUN docker-php-ext-install  -j$(nproc) opcache intl

RUN docker-php-ext-install  -j$(nproc) bz2 zip
### Install APCu Not after 10.0
#RUN printf "\n" |pecl install apcu
#RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

ENV VERSION_GLPI 10.0.3
#GLPI
WORKDIR /var/www/html/
RUN wget "https://github.com/glpi-project/glpi/releases/download/${VERSION_GLPI}/glpi-${VERSION_GLPI}.tgz" -O - | tar -xz && mv glpi/* . 
RUN mv glpi/.ht* . && rm -rf glpi
RUN chown -R www-data .
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

