#!/bin/bash

# Récupérez les variables d'environnement
if [ -z "$REPO_NAME" ]; then
    echo "Erreur: la variable REPO_NAME n'est pas définie."
    exit 1
fi
if [ -z "$REMOTE_URL" ]; then
    echo "Erreur: la variable GIT_REMOTE_URL n'est pas définie."
    exit 1
fi

TARGET_DIR="/api/$REPO_NAME"



# Si le dossier n'existe pas ou s'il n'est pas un dépôt git valide
if [ ! -d "$TARGET_DIR" ] || [ ! -d "$TARGET_DIR/.git" ]; then
    # Supprimer le répertoire s'il existe
    rm -rf $TARGET_DIR
    # Cloner le dépôt
    git clone $REMOTE_URL $TARGET_DIR
    if [ $? -ne 0 ]; then
        echo "Erreur lors du clonage du dépôt."
        exit 1
    fi
fi
fit status

cd $TARGET_DIR

git remote | grep -q '^gitea$'
if [ $? -ne 0 ]; then
    git remote add gitea $REMOTE_URL
fi

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
