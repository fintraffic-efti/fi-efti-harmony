#!/usr/bin/env bash

/opt/efti/bin/init_stores.sh "$EFTI_AP_KEYSTORE_BASE64" "$EFTI_AP_TRUSTSTORE_BASE64" "$EFTI_TLS_KEYSTORE_BASE64" "$EFTI_TLS_TRUSTSTORE_BASE64"
/opt/efti/bin/init_wsplugin.sh $EFTI_WSPLUGIN_PROPERTIES_BASE64
/opt/efti/bin/wait_for_harmony.sh /opt/efti/bin/init_pmode.sh "$ADMIN_PASSWORD" "$EFTI_PMODE_ADMIN_PASSWORD" "$EFTI_PMODE_BASE64" &
/opt/harmony-ap/bin/entrypoint.sh
