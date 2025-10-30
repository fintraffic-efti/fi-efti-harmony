#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

/opt/efti/bin/init_stores.sh "$EFTI_AP_KEYSTORE_BASE64" "$EFTI_AP_TRUSTSTORE_BASE64" "$EFTI_TLS_KEYSTORE_BASE64" "$EFTI_TLS_TRUSTSTORE_BASE64"
/opt/efti/bin/init_wsplugin.sh $EFTI_WSPLUGIN_PROPERTIES_BASE64
if [ -z "${EFTI_LOGBACK_XML_BASE64:-}" ]; then
  echo "EFTI_LOGBACK_XML_BASE64 not set, skipping logback initialization"
else
  /opt/efti/bin/init_logback.sh $EFTI_LOGBACK_XML_BASE64
fi

/opt/efti/bin/wait_for_harmony.sh /opt/efti/bin/init_pmode.sh "$ADMIN_PASSWORD" "$EFTI_PMODE_ADMIN_PASSWORD" "$EFTI_PMODE_BASE64" &
PMODE_INIT_PID=$!

# Start harmony in background so that we may easily check wait_for_harmony.sh status
exec /usr/bin/harmony-entrypoint "$@" &
HARMONY_PID=$!

# Note: this will wait for wait_for_harmony.sh to finish (error or timeout) even if harmony_entrypoint.sh
# exited (probably with an error status).
wait $PMODE_INIT_PID
PMODE_INIT_STATUS=$?

if [[ $PMODE_INIT_STATUS -ne 0 ]]; then
  echo "Got exit status $PMODE_INIT_STATUS from wait_for_harmony.sh/init_pmode.sh"
  exit $PMODE_INIT_STATUS
fi

# Wait for harmony process to finish
wait $HARMONY_PID
