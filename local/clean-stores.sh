#!/usr/bin/env bash

set -o pipefail
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.

cd $(dirname $0)

rm -rf "h1/stores"
rm -rf "h2/stores"
