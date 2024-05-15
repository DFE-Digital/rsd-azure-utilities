locals {
  region                             = "westeurope"
  environment                        = "s184d01-"
  project_name                       = "afd-domain-renewal"
  resource_prefix                    = "${local.environment}${local.project_name}"
  registry_server                    = var.registry_server
  registry_username                  = var.registry_username
  registry_password                  = var.registry_password
  registry_image_name                = "dfe-digital/rsd-afd-custom-domain-validator"
  registry_image_tag                 = "latest"
  job_cpu                            = 0.5
  job_memory                         = 1
  virtual_network_address_space      = "172.16.0.0/12"
  virtual_network_address_space_mask = element(split("/", local.virtual_network_address_space), 1)
  container_apps_infra_subnet_cidr   = cidrsubnet(local.virtual_network_address_space, 21 - local.virtual_network_address_space_mask, 0)

  tags = {
    "Environment"      = "Dev"
    "Product"          = "Complete Conversions, Transfers and Changes"
    "Service Offering" = "Complete Conversions, Transfers and Changes"
    "GitHub"           = "rsd-afd-custom-domain-validator"
    "Service Name"     = "RSD Front Door TLS Renewal"
  }
}
