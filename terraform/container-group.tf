resource "azurerm_container_group" "default" {
  name                = local.resource_prefix
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  ip_address_type     = "Private"
  os_type             = "Linux"

  dynamic "container" {
    for_each = local.container_jobs

    content {
      name     = container.key
      image    = "${local.registry_server}/${container.value.image_name}:${container.value.image_tag}"
      cpu      = local.job_cpu
      memory   = local.job_memory
      commands = ["/bin/bash", "-c", "./start bin/${container.value.script}"]

      ports { # bogus
        port     = 65500 + index(keys(local.container_jobs), container.key)
        protocol = "TCP"
      }

      environment_variables = {
        "AZURE_CLIENT_ID"       = azurerm_user_assigned_identity.default.client_id
        "AZ_SUBSCRIPTION_SCOPE" = data.azurerm_subscription.current.display_name
        "SLACK_WEBHOOK_URL"     = local.slack_webhook_url
      }
    }
  }

  image_registry_credential {
    server                    = local.registry_server
    user_assigned_identity_id = azurerm_user_assigned_identity.default.id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.default.id]
  }

  exposed_port   = []
  restart_policy = "Never"
  subnet_ids     = [azurerm_subnet.default.id]

  tags = local.tags
}

# necessary because of: https://github.com/Azure/azure-rest-api-specs/issues/9768
resource "azapi_update_resource" "patch_logs" {
  type        = "Microsoft.ContainerInstance/containerGroups@2023-05-01"
  resource_id = azurerm_container_group.default.id

  body = {
    properties = {
      diagnostics : {
        logAnalytics : {
          "logType" : "ContainerInstanceLogs",
          "workspaceId" : azurerm_log_analytics_workspace.default.workspace_id,
          "workspaceKey" : azurerm_log_analytics_workspace.default.primary_shared_key
        }
      },
      imageRegistryCredentials : [
        {
          "server" : local.registry_server,
          "user_assigned_identity_id" : azurerm_user_assigned_identity.default.id
        }
      ]
    }
  }

  lifecycle {
    replace_triggered_by = [azurerm_log_analytics_workspace.default.workspace_id]
  }
}
