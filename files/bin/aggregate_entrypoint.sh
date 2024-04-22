#!/usr/bin/env bash

/opt/efti/bin/wait_for_harmony.sh /opt/efti/bin/init_pmode.sh "$ADMIN_PASSWORD" "$PMODE_ADMIN_PASSWORD" "$EFTI_PMODE_PATH" &
/opt/harmony-ap/bin/entrypoint.sh
