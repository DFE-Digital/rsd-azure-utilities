#!/bin/bash
# exit on failures
set -e
set -o pipefail

az login --identity
az account set --subscription "$AZ_SUBSCRIPTION_SCOPE"

exec "$@"

exit 0
# If the script reaches this point, it means the job was successful
