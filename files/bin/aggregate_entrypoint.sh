#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

/opt/efti/bin/init_wsplugin.sh $EFTI_WSPLUGIN_PROPERTIES_BASE64
if [ -z "${EFTI_LOGBACK_XML_BASE64:-}" ]; then
  echo "EFTI_LOGBACK_XML_BASE64 not set, skipping logback initialization"
else
  /opt/efti/bin/init_logback.sh $EFTI_LOGBACK_XML_BASE64
fi

exec /usr/bin/harmony-entrypoint "$@"
