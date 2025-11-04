#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

/opt/efti/bin/init_wsplugin.sh $EFTI_WSPLUGIN_PROPERTIES_BASE64

exec /usr/bin/harmony-entrypoint "$@"
