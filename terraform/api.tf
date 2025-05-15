resource "azurerm_api_connection" "linkedservice" {
  count = local.api_connection_client_id != "" ? 1 : 0

  name                = "aci"
  resource_group_name = azurerm_resource_group.default.name
  managed_api_id      = data.azurerm_managed_api.container_instance_group.id
  display_name        = "${local.resource_prefix}-job"

  parameter_values = {
    "token:clientId" : local.api_connection_client_id,
    "token:clientSecret" : azuread_application_password.aci_service_principal[0].value,
    "token:TenantId" : data.azurerm_subscription.current.tenant_id,
    "token:grantType" : "client_credentials"
  }

  lifecycle {
    # NOTE: Az API does not return sensitive values so there will always be a diff without this
    ignore_changes = [
      parameter_values
    ]
  }

  tags = local.tags
}

resource "azuread_application_password" "aci_service_principal" {
  count = local.api_connection_client_id != "" ? 1 : 0

  display_name   = local.resource_prefix
  application_id = data.azuread_application.aci_service_principal[0].id

  end_date = timeadd(
    time_rotating.annual[0].rotation_rfc3339,
    "2160h" # +90 days from the 'time_rotating' resource
  )

  rotate_when_changed = {
    rotation = time_rotating.annual[0].id
  }
}

resource "time_rotating" "annual" {
  count = local.api_connection_client_id != "" ? 1 : 0

  rotation_days = 365
}
