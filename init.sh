#!/bin/bash

if [ ! -f .env ]; then
    # Génère un mot de passe aléatoire pour la base de données
    DB_PASSWORD=$(openssl rand -base64 16)
    GITEA_DB_PASSWORD=$(openssl rand -base64 16)

    # Enregistre les mots de passe dans le fichier .env
    echo "DB_PASSWORD=$DB_PASSWORD" >> .env
    echo "GITEA_DB_PASSWORD=$GITEA_DB_PASSWORD" >> .env

    # Affiche les mots de passe à l'utilisateur
    echo "Mots de passe générés:"
    echo "DB_PASSWORD: $DB_PASSWORD"
    echo "GITEA_DB_PASSWORD: $GITEA_DB_PASSWORD"
fi

# Lance docker-compose
docker-compose up
