resource "azurerm_resource_group" "default" {
  name     = local.resource_prefix
  location = local.region

  tags = local.tags
}

resource "azurerm_log_analytics_workspace" "default" {
  name                = "${local.resource_prefix}-logs"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = local.tags
}
