#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

WSPLUGIN_PROPERTIES_BASE64=$1
WSPLUGIN_PROPERTIES_PATH=/opt/harmony-ap/plugins/config/ws-plugin.properties

echo
echo "#######################################################################################"
echo "Will deploy WS-Plugin at:"
echo "#######################################################################################"
echo $WSPLUGIN_PROPERTIES_PATH

echo $WSPLUGIN_PROPERTIES_BASE64 | base64 --decode > $WSPLUGIN_PROPERTIES_PATH

echo
echo "#######################################################################################"
echo "Done"
echo "#######################################################################################"
