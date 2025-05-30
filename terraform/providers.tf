provider "azurerm" {
  features {}
  skip_provider_registration = true
  storage_use_azuread        = true
  client_id                  = var.azure_client_id
  client_secret              = var.azure_client_secret
  tenant_id                  = var.azure_tenant_id
  subscription_id            = var.azure_subscription_id
}

provider "azapi" {
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}
