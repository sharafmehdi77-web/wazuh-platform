#!/usr/bin/env bash

set -Eeuo pipefail

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

check() {

    if docker ps --format '{{.Names}}' | grep -q "$1"; then
        echo -e "${GREEN}✔${NC} $2"
    else
        echo -e "${RED}✘${NC} $2"
    fi

}

echo
echo "========== Wazuh Platform =========="
echo

check wazuh.manager "Manager"
check wazuh.indexer "Indexer"
check wazuh.dashboard "Dashboard"

echo
echo "===================================="
