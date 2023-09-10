#!/bin/bash

# Récupérez les variables d'environnement
if [ -z "$REPO_NAME" ]; then
    echo "Erreur: la variable REPO_NAME n'est pas définie."
    exit 1
fi

TARGET_DIR="/api/$REPO_NAME"

# Vérifiez si le répertoire du dépôt existe
if [ ! -d "$TARGET_DIR" ]; then
    echo "Erreur: le répertoire $TARGET_DIR n'existe pas."
    exit 1
fi

# Allez dans le répertoire de l'API
cd $TARGET_DIR

# Pull les derniers changements
git pull gitea main
if [ $? -ne 0 ]; then
    echo "Erreur lors de la mise à jour du dépôt."
    exit 1
fi

# Exécution du composer install 
composer install
if [ $? -ne 0 ]; then
    echo "Erreur lors de l'exécution de composer install."
    exit 1
fi

# Exécution PHP pour vider le cache
php bin/console cache:clear --env=prod
if [ $? -ne 0 ]; then
    echo "Erreur lors de la suppression du cache."
    exit 1
fi

echo "Script terminé avec succès!"
