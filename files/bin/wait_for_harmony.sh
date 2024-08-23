#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

cmd="$@"

>&2 echo 'Waiting for Harmony to start before proceeding'

EXTERNAL_LB=${EXTERNAL_LB:-false}
DEPLOYMENT_CLUSTERED=${DEPLOYMENT_CLUSTERED:-false}

if [ "$EXTERNAL_LB" = "true" ] || [ "$DEPLOYMENT_CLUSTERED" = "true" ]; then
    >&2 echo "Expecting harmony to listen on http port (EXTERNAL_LB=$EXTERNAL_LB, DEPLOYMENT_CLUSTERED=$DEPLOYMENT_CLUSTERED)"
    PROTOCOL='http'
    PORT=8080
else
    >&2 echo "Expecting harmony to listen on https port (EXTERNAL_LB=$EXTERNAL_LB, DEPLOYMENT_CLUSTERED=$DEPLOYMENT_CLUSTERED)"
    PROTOCOL='https'
    PORT=8443
fi

sleepcount=0
until curl --silent --output /dev/null --insecure $PROTOCOL://127.0.0.1:$PORT; do
  # sleep max 120 iterations
  if (( "$sleepcount" < "120" )); then
    >&2 echo "Harmony is unavailable - sleeping"
    (( ++sleepcount ))
    sleep 5
  else
    >&2 echo "Timeout!"
    exit 1
  fi
done

>&2 echo "Harmony is up - executing command"
exec $cmd
