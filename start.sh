#!/usr/bin/env bash

PMODE_ENV=.pmode.env
STORES_ENV=.stores.env

echo "EFTI_PMODE_BASE64=""$(cat dev/dev_pmode.xml | base64 --wrap 0)""" > "$PMODE_ENV"

rm -f "$STORES_ENV"
echo "EFTI_AP_KEYSTORE_BASE64=""$(cat local/ap-keystore.p12 | base64 --wrap 0)""" >> "$STORES_ENV"
echo "EFTI_AP_TRUSTSTORE_BASE64=""$(cat local/ap-truststore.p12 | base64 --wrap 0)""" >> "$STORES_ENV"
echo "EFTI_TLS_KEYSTORE_BASE64=""$(cat local/tls-keystore.p12 | base64 --wrap 0)""" >> "$STORES_ENV"
echo "EFTI_TLS_TRUSTSTORE_BASE64=""$(cat local/tls-truststore.p12 | base64 --wrap 0)""" >> "$STORES_ENV"

docker compose up --force-recreate --build harmony
