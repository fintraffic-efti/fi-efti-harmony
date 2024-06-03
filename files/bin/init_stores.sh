#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

AP_KEYSTORE_BASE64=$1
AP_TRUSTSTORE_BASE64=$2
TLS_KEYSTORE_BASE64=$3
TLS_TRUSTSTORE_BASE64=$4

STORE_ROOT_PATH=/var/opt/harmony-ap/etc
AP_KEYSTORE_PATH="$STORE_ROOT_PATH/ap-keystore.p12"
AP_TRUSTSTORE_PATH="$STORE_ROOT_PATH/ap-truststore.p12"
TLS_KEYSTORE_PATH="$STORE_ROOT_PATH/tls-keystore.p12"
TLS_TRUSTSTORE_PATH="$STORE_ROOT_PATH/tls-truststore.p12"

echo
echo "#######################################################################################"
echo "Will deploy keystores and truststores at:"
echo "#######################################################################################"
echo "$AP_KEYSTORE_PATH"
echo "$AP_TRUSTSTORE_PATH"
echo "$TLS_KEYSTORE_PATH"
echo "$TLS_TRUSTSTORE_PATH"

mkdir -p $STORE_ROOT_PATH
echo "$AP_KEYSTORE_BASE64" | base64 --decode > "$AP_KEYSTORE_PATH"
echo "$AP_TRUSTSTORE_BASE64" | base64 --decode > "$AP_TRUSTSTORE_PATH"
echo "$TLS_KEYSTORE_BASE64" | base64 --decode > "$TLS_KEYSTORE_PATH"
echo "$TLS_TRUSTSTORE_BASE64" | base64 --decode > "$TLS_TRUSTSTORE_PATH"

echo
echo "#######################################################################################"
echo "Done"
echo "#######################################################################################"
