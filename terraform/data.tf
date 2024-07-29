data "azurerm_subscription" "current" {}

data "azurerm_managed_api" "container_instance_group" {
  name     = "aci"
  location = azurerm_resource_group.default.location
}
