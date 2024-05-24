#!/usr/bin/env bash

set -o pipefail
set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error when substituting.
set -x # Echo commands

cd $(dirname $0)

../scripts/create-stores-for-pair.sh h1/stores h1 harmony-h1 h2/stores h2 harmony-h2
