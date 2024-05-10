#!/usr/bin/env bash
set -e

PMODE_ENV=.pmode.env
STORES_ENV=.stores.env
WSPLUGIN_ENV=.wsplugin.env

base64Path() {
  #OSX
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo $(cat $1 | base64 --break 0)
  else
    echo $(cat $1 | base64 --wrap 0)
  fi
}

echo "EFTI_PMODE_BASE64=""$(base64Path local/dev_pmode.xml)""" > $PMODE_ENV
echo "EFTI_WSPLUGIN_PROPERTIES_BASE64=""$(base64Path local/ws-plugin.properties)""" > $WSPLUGIN_ENV

rm -f $STORES_ENV
echo "EFTI_AP_KEYSTORE_BASE64=""$(base64Path local/ap-keystore.p12)""" >> $STORES_ENV
echo "EFTI_AP_TRUSTSTORE_BASE64=""$(base64Path local/ap-truststore.p12)""" >> $STORES_ENV
echo "EFTI_TLS_KEYSTORE_BASE64=""$(base64Path local/tls-keystore.p12)""" >> $STORES_ENV
echo "EFTI_TLS_TRUSTSTORE_BASE64=""$(base64Path local/tls-truststore.p12)""" >> $STORES_ENV


docker compose up --force-recreate --build harmony
