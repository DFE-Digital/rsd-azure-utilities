#!/bin/bash
# exit on failures
set -e
set -o pipefail

# Log in with Azure Identity
echo "Attempting to login..."
az login --identity

echo "Beginning job..."
bash /afd-domain-scan.sh

exit
