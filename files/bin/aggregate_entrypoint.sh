#!/usr/bin/env bash

/opt/harmony-ap/bin/wait_for_harmony.sh /opt/harmony-ap/bin/init_pmode.sh "$ADMIN_PASSWORD" "$PMODE_ADMIN_PASSWORD" "$EFTI_PMODE_PATH" &
/opt/harmony-ap/bin/entrypoint.sh
