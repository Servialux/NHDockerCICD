FROM node:18

ARG NAME
ARG REPO_NAME
ARG REPO_URL
ARG REMOTE_URL
# RECUPERATION DES ARGUMENTS
ENV NAME=$APP_NAME
ENV REPO_NAME=$APP_REPO_NAME
ENV REPO_URL=$APP_REPO_URL
ENV REMOTE_URL=$APP_REMOTE_URL

WORKDIR /api/$REPO_NAME

COPY ./EndpointScript/deploy.sh /api/deploy.sh
COPY ./EndpointScript/init.sh /api/init.sh

RUN chmod +x /api/deploy.sh
RUN chmod +x /api/init.sh
# Si package.json existe, installez les dépendances. Sinon, ignorez.
RUN if [ -f package.json ]; then npm install; fi

# Si package.json existe, exécutez npm start. Sinon, mettez le conteneur en sommeil indéfiniment.
CMD if [ -f package.json ]; then npm start; else tail -f /dev/null; fi
