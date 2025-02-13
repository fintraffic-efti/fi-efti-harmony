#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

LOGBACK_XML_BASE64=$1
HARMONY_CONFIG_DIR=/var/opt/harmony-ap/etc

echo
echo "Will deploy logback.xml at: $HARMONY_CONFIG_DIR"

mkdir -p $HARMONY_CONFIG_DIR
echo $LOGBACK_XML_BASE64 | base64 --decode > $HARMONY_CONFIG_DIR/logback.xml

echo
echo "logback.xml initialization done"
