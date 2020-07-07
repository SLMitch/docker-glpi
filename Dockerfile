FROM php:7-apache
RUN apt-get update && apt-get install -y wget \
  	libfreetype6-dev \
        libjpeg62-turbo-dev  libc-client-dev libkrb5-dev \
        libpng-dev  libldap2-dev libxml2-dev  && rm -rf /var/cache/apt

RUN docker-php-ext-configure gd  \
    && docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) ldap mysqli xmlrpc soap

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Install opcache 
RUN docker-php-ext-install opcache

# Install APCu 
RUN pecl install apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

ENV VERSION_GLPI 9.4.6
#GLPI
WORKDIR /var/www/html/
RUN wget "https://github.com/glpi-project/glpi/releases/download/${VERSION_GLPI}/glpi-${VERSION_GLPI}.tgz" -O - | tar -xz && mv glpi/* . 
RUN mv glpi/.ht* . && rm -rf glpi
RUN chown -R www-data .

