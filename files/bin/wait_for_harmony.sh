#!/usr/bin/env bash

set -e

if [ -z $EFTI_HARMONY_PORT ]
then
  EFTI_HARMONY_PORT=8443
fi

cmd="$@"

sleepcount=0
until curl --silent --output /dev/null --insecure https://127.0.0.1:$EFTI_HARMONY_PORT; do
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
