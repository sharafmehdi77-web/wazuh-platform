#!/usr/bin/env bash

echo "Stopping platform..."

docker compose down

echo
echo "Removing unused images..."

docker image prune -f

echo
echo "Cleanup complete."
