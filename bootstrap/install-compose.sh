#!/usr/bin/env bash

set -Eeuo pipefail

if docker compose version >/dev/null 2>&1; then
    echo "[OK] Docker Compose already installed."
    docker compose version
    exit 0
fi

echo "[INFO] Installing Docker Compose plugin..."

sudo apt-get update
sudo apt-get install -y docker-compose-plugin

echo "[OK] Docker Compose installed."

docker compose version
