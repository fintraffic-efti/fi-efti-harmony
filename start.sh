#!/usr/bin/env bash
set -e

./local/create-local-stores.sh
./local/config.sh 'h1'
./local/config.sh 'h2'

docker compose up -d --build
