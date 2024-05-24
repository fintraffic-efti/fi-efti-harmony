#!/usr/bin/env bash

set -o pipefail
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.
set -x # Echo commands

create_ap_crt() {
  local out=$1
  local hostname=$2
  openssl req -newkey rsa:2048 -nodes -keyout "$out/ap.key" -x509 -days 365 -out "$out/ap.crt" -subj "/CN=$hostname"
}

create_tls_crt() {
  local out=$1
  local hostname=$2
  openssl req -newkey rsa:2048 -nodes -keyout "$out/tls.key" -x509 -days 365 -out "$out/tls.crt" -subj "/CN=$hostname" -addext "subjectAltName = DNS:$hostname"
}

create_ap_ks() {
  local out=$1
  local passphrase=$2
  local party_name=$3
  openssl pkcs12 -export -out "$out/ap-keystore.p12" -inkey "$out/ap.key" -in "$out/ap.crt" -passout "pass:$passphrase"
  keytool -changealias -alias "1" -destalias $party_name -keystore "$out/ap-keystore.p12" -storepass "$passphrase"
}

create_ap_ts() {
  local out_ts=$1
  local passphrase=$2
  local out_crt=$3
  local party_name_crt=$4
  keytool -import -file "$out_crt/ap.crt" -keystore "$out_ts/ap-truststore.p12" -noprompt -storepass "$passphrase"
  keytool -changealias -alias "mykey" -destalias $party_name_crt -keystore "$out_ts/ap-truststore.p12" -storepass "$passphrase"
}

create_tls_ks() {
  local out=$1
  local passphrase=$2
  local party_name=$3
  openssl pkcs12 -export -out "$out/tls-keystore.p12" -inkey "$out/tls.key" -in "$out/tls.crt" -passout "pass:$passphrase"
  keytool -changealias -alias "1" -destalias "$party_name" -keystore "$out/tls-keystore.p12" -storepass "$passphrase"
}

create_tls_ts() {
  local out_ts=$1
  local passphrase=$2
  local out_crt=$3
  local party_name_crt=$4
  keytool -import -alias "$party_name_crt" -file "$out_crt/tls.crt" -keystore "$out_ts/tls-truststore.p12" -noprompt -storepass "$passphrase"
}

out_a=$1
party_name_a=$2
hostname_a=$3
out_b=$4
party_name_b=$5
hostname_b=$6

passphrase_ap_ks_a="ap-keystore-$party_name_a"
passphrase_ap_ks_b="ap-keystore-$party_name_b"
passphrase_ap_ts_a="ap-truststore-$party_name_a"
passphrase_ap_ts_b="ap-truststore-$party_name_b"
passphrase_tls_ks_a="tls-keystore-$party_name_a"
passphrase_tls_ks_b="tls-keystore-$party_name_b"
passphrase_tls_ts_a="tls-truststore-$party_name_a"
passphrase_tls_ts_b="tls-truststore-$party_name_b"

if [ -d "$out_a" ]; then
  echo "Output directory $out_a already exists, remove directory if you want to recreate stores."
  exit 0
fi
if [ -d "$out_b" ]; then
  echo "Output directory $out_b already exists, remove directory if you want to recreate stores."
  exit 0
fi

mkdir -p $out_a
mkdir -p $out_b

create_ap_crt $out_a $hostname_a
create_ap_crt $out_b $hostname_b

create_tls_crt $out_a $hostname_a
create_tls_crt $out_b $hostname_b

create_ap_ks $out_a "$passphrase_ap_ks_a" $party_name_a
create_ap_ks $out_b "$passphrase_ap_ks_b" $party_name_b

create_ap_ts $out_a "$passphrase_ap_ts_a" $out_b $party_name_b
create_ap_ts $out_b "$passphrase_ap_ts_b" $out_a $party_name_a

create_tls_ks $out_a "$passphrase_tls_ks_a" $party_name_a
create_tls_ks $out_b "$passphrase_tls_ks_b" $party_name_b

create_tls_ts $out_a "$passphrase_tls_ts_a" $out_b $party_name_b
create_tls_ts $out_b "$passphrase_tls_ts_b" $out_a $party_name_a
