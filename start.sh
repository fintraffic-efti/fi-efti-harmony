#!/usr/bin/env bash

echo "EFTI_PMODE_BASE64=""$(cat dev/dev_pmode.xml | base64 --wrap 0)""" > .pmode.env
docker compose up --force-recreate --build harmony
