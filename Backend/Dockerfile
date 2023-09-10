FROM php:8.2-fpm

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Installez les extensions nécessaires
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    unzip \
    && docker-php-ext-install pdo pdo_pgsql

RUN chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gd xdebug

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
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

WORKDIR /api/$REPO_NAME

COPY ./EndpointScript/deploy.sh /api/deploy.sh
COPY ./EndpointScript/init.sh /api/init.sh

RUN chmod +x /api/deploy.sh
RUN chmod +x /api/init.sh
CMD ["php-fpm"]
