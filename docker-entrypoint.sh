#!/bin/bash

# exit on failures
set -e
set -o pipefail

# Log in with Azure Identity
az login --identity --username "${CLIENT_ID}"

while true:
do
  bash /afd-domain-scan.sh
  echo
  echo "Going to sleep for 4 hours.."
  sleep 144100 # 4 hours
done
