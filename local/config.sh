#!/usr/bin/env bash

set -o pipefail
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

cd $(dirname $0)

instance=$1
env_file="$instance/.env"

base64Path() {
  #OSX
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo $(cat $1 | base64 --break 0)
  else
    echo $(cat $1 | base64 --wrap 0)
  fi
}

rm -f "$env_file"
echo "EFTI_PMODE_BASE64=""$(base64Path $instance/pmode.xml)""" >> "$env_file"
echo "EFTI_AP_KEYSTORE_BASE64=""$(base64Path $instance/stores/ap-keystore.p12)""" >> "$env_file"
echo "EFTI_AP_TRUSTSTORE_BASE64=""$(base64Path $instance/stores/ap-truststore.p12)""" >> "$env_file"
echo "EFTI_TLS_KEYSTORE_BASE64=""$(base64Path $instance/stores/tls-keystore.p12)""" >> "$env_file"
echo "EFTI_TLS_TRUSTSTORE_BASE64=""$(base64Path $instance/stores/tls-truststore.p12)""" >> "$env_file"
echo "EFTI_WSPLUGIN_PROPERTIES_BASE64=""$(base64Path $instance/wsplugin.properties)""" >> "$env_file"
