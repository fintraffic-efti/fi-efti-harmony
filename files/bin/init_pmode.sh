#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

ADMIN_USER=harmony
HARMONY_ADMIN_PWD=$1
PMODE_ADMIN_PWD=$2
PMODE_BASE64=$3

PMODE_PATH=$(mktemp --suffix=.xml)
COOKIE_FILE=$(mktemp)

if [ -n $EFTI_HARMONY_PORT ]; then
  EFTI_HARMONY_PORT=8443
fi

if [ -n $EXTERNAL_LB ]; then
    EXTERNAL_LB='false'
fi

if [ $EXTERNAL_LB == 'true' ]; then
    echo 'Using http for pmode configuration'
    PROTOCOL='http'
else
    echo 'Using https for pmode configuration'
    PROTOCOL='https'
fi


echo "$PMODE_BASE64" | base64 --decode > "$PMODE_PATH"

echo
echo "#######################################################################################"
echo "Will try to upload this pmode content from $PMODE_PATH:"
echo "#######################################################################################"
cat "$PMODE_PATH"

echo
echo "#######################################################################################"
echo "Login to harmony as admin user"
echo "#######################################################################################"
curl -X POST \
  --cookie-jar "$COOKIE_FILE" \
  -H 'Content-Type: application/json' \
  -d '{"username" : "'"$ADMIN_USER"'", "password" : "'"$HARMONY_ADMIN_PWD"'"}' \
  --insecure \
  "$PROTOCOL://localhost:$EFTI_HARMONY_PORT/rest/security/authentication"

XSRF_TOKEN=$(grep XSRF-TOKEN "$COOKIE_FILE" | awk '{ print $7; }')

echo
echo "#######################################################################################"
echo "Check if pmode plugin user has already been setup"
echo "#######################################################################################"
USERS_QUERY_FILE=$(mktemp)
curl -X GET \
  -b "$COOKIE_FILE" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -o "$USERS_QUERY_FILE" \
  --insecure \
  "$PROTOCOL://localhost:$EFTI_HARMONY_PORT/rest/plugin/users?userName=pmode_admin"

if grep -q pmode_admin "$USERS_QUERY_FILE"; then
  echo
  echo "#######################################################################################"
  echo "pmode plugin user already exists"
  echo "#######################################################################################"
else
  echo
  echo "#######################################################################################"
  echo "Create pmode plugin user"
  echo "#######################################################################################"
  curl -X PUT \
    -b "$COOKIE_FILE" \
    -H 'Content-Type: application/json' \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -d '[{"status":"NEW","userName":"pmode_admin","active":true,"suspended":false,"authenticationType":"BASIC","authRoles":"ROLE_ADMIN","password":"'"$PMODE_ADMIN_PWD"'"}]' \
    --insecure \
    "$PROTOCOL://localhost:$EFTI_HARMONY_PORT/rest/plugin/users"
fi

echo
echo "#######################################################################################"
echo "Upload pmode from $PMODE_PATH"
echo "#######################################################################################"
curl -u pmode_admin:"$PMODE_ADMIN_PWD" --basic -F file=@"$PMODE_PATH" --insecure "$PROTOCOL://localhost:$EFTI_HARMONY_PORT/ext/pmode?description=pmode"
