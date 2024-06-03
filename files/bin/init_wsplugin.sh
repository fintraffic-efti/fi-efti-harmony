#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

WSPLUGIN_PROPERTIES_BASE64=$1
HARMONY_CONFIG_PATH=/var/opt/harmony-ap/etc/plugins/config
WSPLUGIN_PROPERTIES_PATH=$HARMONY_CONFIG_PATH/ws-plugin.properties

echo
echo "#######################################################################################"
echo "Will deploy WS-Plugin at:"
echo "#######################################################################################"
echo $WSPLUGIN_PROPERTIES_PATH

mkdir -p $HARMONY_CONFIG_PATH
echo $WSPLUGIN_PROPERTIES_BASE64 | base64 --decode > $WSPLUGIN_PROPERTIES_PATH

echo
echo "#######################################################################################"
echo "Done"
echo "#######################################################################################"
