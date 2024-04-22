#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

ADMIN_USER=harmony
HARMONY_ADMIN_PWD=$1
PMODE_ADMIN_PWD=$2
PMODE_PATH=$3

COOKIE_FILE=$(mktemp)

curl -X POST \
  --cookie-jar "$COOKIE_FILE" \
  -H 'Content-Type: application/json' \
  -d '{"username" : "'"$ADMIN_USER"'", "password" : "'"$HARMONY_ADMIN_PWD"'"}' \
  --insecure -v \
  "https://localhost:8443/rest/security/authentication"

XSRF_TOKEN=$(grep XSRF-TOKEN "$COOKIE_FILE" | awk '{ print $7; }')

curl -X PUT \
  -b "$COOKIE_FILE" \
  -H 'Content-Type: application/json' \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -d '[{"status":"NEW","userName":"pmode_admin","active":true,"suspended":false,"authenticationType":"BASIC","authRoles":"ROLE_ADMIN","password":"'"$PMODE_ADMIN_PWD"'"}]' \
  --insecure -v \
  "https://localhost:8443/rest/plugin/users"

curl -u pmode_admin:"$PMODE_ADMIN_PWD" --basic -F file=@"$PMODE_PATH" --insecure -v "https://localhost:8443/ext/pmode?description=pmode"

echo "DONE"
