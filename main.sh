#!/bin/bash

# Récupérer les clés publiques des conteneurs
docker cp frontend:/root/.ssh/id_rsa.pub ./frontend_key.pub
docker cp backend:/root/.ssh/id_rsakey.pub ./backend_key.pub

# Variables (à personnaliser selon votre configuration)
GITEA_URL="http://localhost:3000"
GITEA_USER="your_gitea_username"
GITEA_PASSWORD="your_gitea_password"
TOKEN_ENDPOINT="$GITEA_URL/api/v1/users/$GITEA_USER/tokens"
KEYS_ENDPOINT="$GITEA_URL/api/v1/user/keys"

# Récupérer un token d'accès à l'API Gitea (vous pouvez pré-générer ce token et l'utiliser directement)
GITEA_TOKEN=$(curl -s -X POST "$TOKEN_ENDPOINT" -u "$GITEA_USER:$GITEA_PASSWORD" -H "Content-Type: application/json" -d '{"name": "docker_key_upload"}' | jq -r .sha1)

if [ -z "$GITEA_TOKEN" ]; then
    echo "Erreur lors de la récupération du token Gitea."
    exit 1
fi

# Envoyer les clés à Gitea
curl -X POST "$KEYS_ENDPOINT" -H "token: $GITEA_TOKEN" -F "title=frontend" -F "key=@./frontend_key.pub"
curl -X POST "$KEYS_ENDPOINT" -H "token: $GITEA_TOKEN" -F "title=backend" -F "key=@./backend_key.pub"
