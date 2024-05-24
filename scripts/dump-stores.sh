#!/usr/bin/env bash

set -o pipefail
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

root_dir=$1
instance_id=$2

cd "$root_dir"
cd "$instance_id/stores"

echo "Dumping stores for $instance_id"
echo

set -x # Echo commands

keytool --list -keystore ap-keystore.p12 -v -storepass ap-keystore-$instance_id
echo
keytool --list -keystore ap-truststore.p12 -v -storepass ap-truststore-$instance_id
echo
keytool --list -keystore tls-keystore.p12 -v -storepass tls-keystore-$instance_id
echo
keytool --list -keystore tls-truststore.p12 -v -storepass tls-truststore-$instance_id
