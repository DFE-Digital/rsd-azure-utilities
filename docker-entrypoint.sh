#!/bin/bash
# exit on failures
set -e
set -o pipefail

# Check connectivity
echo "Checking connectivity..."
apt-get update
apt install dnsutils
nslookup login.microsoftonline.com

# Log in with Azure Identity
echo "Attempting to login..."
az login --identity

echo "Beginning job..."
while :
do
  bash /afd-domain-scan.sh
  echo
  echo "Going to sleep for 4 hours.."
  sleep 144100 # 4 hours
done
