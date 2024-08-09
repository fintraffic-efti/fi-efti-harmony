#!/usr/bin/env bash

set -e
cmd="$@"

>&2 echo 'Waiting for Harmony to start before proceeding'

EXTERNAL_LB=${EXTERNAL_LB:-false}

if [ "$EXTERNAL_LB" = "true" ]; then
    >&2 echo 'Using http for pmode configuration'
    PROTOCOL='http'
    PORT=8080
else
    >&2 echo 'Using https for pmode configuration'
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
