FROM php:8.2-apache
RUN apt-get update && apt-get install -y wget \
  	libfreetype6-dev \
        libjpeg62-turbo-dev  libc-client-dev libkrb5-dev \
        libpng-dev  libldap2-dev libxml2-dev libbz2-dev libzip-dev graphviz  && rm -rf /var/cache/apt

RUN docker-php-ext-configure gd  && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) ldap mysqli soap
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap
# Install php module
RUN docker-php-ext-install  -j$(nproc) opcache intl  exif bz2 zip

#MOD REWRITE
RUN a2enmod rewrite

ENV VERSION_GLPI 10.0.11
#GLPI
WORKDIR /var/www/html/
RUN wget "https://github.com/glpi-project/glpi/releases/download/${VERSION_GLPI}/glpi-${VERSION_GLPI}.tgz" -O - | tar -xz && mv glpi/* . && mv glpi/.ht* . && rm -rf glpi &&  chown -R www-data .
COPY htaccess /var/www/html/.htaccess
RUN chown -R www-data .htaccess
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

