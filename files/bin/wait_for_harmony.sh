#!/usr/bin/env bash

set -e

cmd="$@"

sleepcount=0
until curl --silent --insecure https://127.0.0.1:8443; do
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
