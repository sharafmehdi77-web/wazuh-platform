#!/usr/bin/env bash

set -Eeuo pipefail

GREEN="\033[0;32m"
BLUE="\033[0;34m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
NC="\033[0m"

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[ OK ]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[FAIL]${NC} $1"
}

echo
echo "======================================"
echo "     Wazuh Platform Bootstrap"
echo "======================================"
echo

#
# Docker
#

info "Checking Docker..."

./bootstrap/install-docker.sh

#
# Compose
#

info "Checking Docker Compose..."

./bootstrap/install-compose.sh

#
# Certificates
#

if [ -d "config/wazuh_indexer_ssl_certs" ]; then
    success "Certificates already exist."
else
    info "Generating certificates..."

    docker compose \
        -f generate-indexer-certs.yml \
        run --rm generator

    success "Certificates generated."
fi

#
# Pull Images
#

info "Pulling latest images..."

docker compose pull

#
# Start Platform
#

info "Starting Wazuh Platform..."

docker compose up -d

#
# Containers
#

echo
docker ps

echo
success "Bootstrap completed."
