FROM php:8.2-fpm

# ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Installez les extensions nécessaires
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
      apt-utils \
      && apt-get install -y \
      procps \
      nano \
      git \
      unzip \
      libicu-dev \
      zlib1g-dev \
      libxml2 \
      libxml2-dev \
      libreadline-dev \
      supervisor \
      cron \
      sudo \
      libzip-dev \
      wget \
      libpq-dev \
      librabbitmq-dev \
    && pecl install amqp \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure intl \
    && yes '' | pecl install -o -f redis && docker-php-ext-enable redis \
    && docker-php-ext-install -j$(nproc) pgsql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install \
      pdo_mysql \
      sockets \
      intl \
      opcache \
      zip \
    && docker-php-ext-enable amqp \
    && rm -rf /tmp/* \
    && rm -rf /var/list/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean
 
# RUN chmod +x /usr/local/bin/install-php-extensions && \
#     install-php-extensions gd xdebug

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN chmod +x /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1

# Create RSA Keys
RUN ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""
# DEFNITION DES ARGUMENTS
ARG NAME
ARG REPO_NAME
ARG REPO_URL
ARG REMOTE_URL

# RECUPERATION DES ARGUMENTS
ENV NAME=$NAME
ENV REPO_NAME=$REPO_NAME
ENV REPO_URL=$REPO_URL
ENV REMOTE_URL=$REMOTE_URL

COPY ./EndpointScript/deploy.sh /var/www/html/deploy.sh
COPY ./EndpointScript/init.sh /var/www/html/init.sh
COPY ./EndpointScript/deploy.php /var/www/html/deploy.php

RUN chown www-data:www-data /var/www/html/deploy.php
RUN chmod +x /var/www/html/deploy.php

RUN chmod +x /var/www/html/deploy.sh
RUN chmod +x /var/www/html/init.sh

RUN cat /root/.ssh/id_rsa.pub
CMD ["php-fpm"]
