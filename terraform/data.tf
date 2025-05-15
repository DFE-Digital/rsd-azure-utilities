data "azurerm_subscription" "current" {}

data "azurerm_managed_api" "container_instance_group" {
  name     = "aci"
  location = azurerm_resource_group.default.location
}

data "azuread_application" "aci_service_principal" {
  count = local.api_connection_client_id != "" ? 1 : 0

  client_id = local.api_connection_client_id
}
