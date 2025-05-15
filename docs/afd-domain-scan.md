# Azure Front Door Domain Validator

## Set up

You will need to do these steps for each Subscription in Azure.

1) Create an App Registration in Entra ID
2) Grant `CDN Profile Contributor` Role to your Service Principal for any
Azure Front Doors you want it to manage
3) Grant `DNS Zone Contributor` Role to your Service Principal for any Public
DNS Zones that are associated with Custom Domains on your Front Door
4) Generate a client secret for your App Registration
5) Build a JSON credential string in the following format
```json
{
  "clientId": "<Application (client) ID>",
  "clientSecret": "<Client Secret>",
  "subscriptionId": "<Subscription ID>",
  "tenantId": "<Directory (tenant) ID>"
}
```
6) On GitHub, create an 'environment' (e.g. dev) and add the JSON string as an
environment secret with the secret name `AZURE_SUBSCRIPTION_CREDENTIALS`.
7) On GitHub, on the same environment, create a second secret with the name
`AZURE_SUBSCRIPTION_NAME` and set the value to the name of your subscription.

## How this works:

Service Principals:

- s184d-afd-domain-validator
- s184t-afd-domain-validator
- s184p-afd-domain-validator

Each of the SP has the relevant roles assigned to Azure Front Door and a public
DNS Zone for each service.

The script held in the root of the repo is executed against each subscription
on a nightly basis using a Cron triggered GitHub Action.

The three workflows are staggered to avoid rate limiting.
