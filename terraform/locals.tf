locals {
  region                             = "westeurope"
  environment                        = var.environment
  project_name                       = "rsd-utilities"
  resource_prefix                    = "${local.environment}${local.project_name}"
  registry_server                    = var.registry_server
  container_jobs                     = var.container_jobs
  job_cpu                            = 0.5
  job_memory                         = 1
  virtual_network_address_space      = "172.16.0.0/12"
  virtual_network_address_space_mask = element(split("/", local.virtual_network_address_space), 1)
  container_apps_infra_subnet_cidr   = cidrsubnet(local.virtual_network_address_space, 21 - local.virtual_network_address_space_mask, 0)
  key_vault_access_ipv4              = var.key_vault_access_ipv4
  tfvars_filename                    = var.tfvars_filename
  api_connection_client_id           = var.api_connection_client_id
  key_vault_subnet_cidr              = cidrsubnet(local.virtual_network_address_space, 21 - local.virtual_network_address_space_mask, 2)
  key_vault_targets                  = var.key_vault_targets
  tags                               = var.tags
}
