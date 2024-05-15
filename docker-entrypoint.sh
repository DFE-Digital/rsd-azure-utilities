#!/bin/bash
echo "Environment:"
printenv

# Log in with Azure Identity
echo "Attempting to login..."
az login --identity --username "${CLIENT_ID}"

echo "Beginning job..."
while true:
do
  bash /afd-domain-scan.sh
  echo
  echo "Going to sleep for 4 hours.."
  sleep 144100 # 4 hours
done
