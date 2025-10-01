# ==============================================================================
# RESOURCE GROUPS
# ==============================================================================

# Hub Resource Group
module "rg_hub" {
  count = var.create_hub_resources ? 1 : 0
  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.hub
  location = var.location
  tags     = local.common_tags
}

# APM Resource Group
module "rg_apm" {
  count = var.create_apm_resources ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.apm
  location = var.location
  tags     = local.common_tags
}

# Management Resource Group
module "rg_management" {
  count = var.create_management_resources ? 1 : 0
  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.management
  location = var.location
  tags     = local.common_tags
}

# Spoke 01 Resource Group
module "rg_spoke01" {
  count = var.create_spoke01_resources ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.spoke01
  location = var.location
  tags     = local.common_tags
}

# Spoke 02 Resource Group
module "rg_spoke02" {
  count = var.create_spoke02_resources ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.spoke02
  location = var.location
  tags     = local.common_tags
}

# IaC Resource Group
module "rg_iac" {
  count = var.create_iac_resources ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.iac
  location = var.location
  tags     = local.common_tags
}

# DNS Resource Group
module "rg_dns" {
  count = var.create_dns_resources ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.dns
  location = var.location
  tags     = local.common_tags
}

# Governance Resource Group
module "rg_governance" {
  count = var.create_monitoring ? 1 : 0

  source   = "../../modules/resource-group"
  name     = local.resource_group_naming.governance
  location = var.location
  tags     = local.common_tags
}

# ==============================================================================
# VIRTUAL NETWORKS
# ==============================================================================

# Hub VNet
module "vnet_hub" {
  count = var.create_hub_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.hub.name
  resource_group_name = module.rg_hub[0].name
  location            = var.location
  address_space       = local.vnet_config.hub.address_space
  subnets             = local.vnet_config.hub.subnets
  tags                = local.common_tags

  depends_on = [module.rg_hub]
}

# APM VNet
module "vnet_apm" {
  count = var.create_apm_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.apm.name
  resource_group_name = module.rg_apm[0].name
  location            = var.location
  address_space       = local.vnet_config.apm.address_space
  subnets             = local.vnet_config.apm.subnets
  tags                = local.common_tags

  depends_on = [module.rg_apm]
}

# Management VNet
module "vnet_management" {
  count = var.create_management_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.management.name
  resource_group_name = module.rg_management[0].name
  location            = var.location
  address_space       = local.vnet_config.management.address_space
  subnets             = local.vnet_config.management.subnets
  tags                = local.common_tags

  depends_on = [module.rg_management]
}

# Spoke 01 VNet
module "vnet_spoke01" {
  count = var.create_spoke01_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.spoke01.name
  resource_group_name = module.rg_spoke01[0].name
  location            = var.location
  address_space       = local.vnet_config.spoke01.address_space
  subnets             = local.vnet_config.spoke01.subnets
  tags                = local.common_tags

  depends_on = [module.rg_spoke01]
}

# Spoke 02 VNet
module "vnet_spoke02" {
  count = var.create_spoke02_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.spoke02.name
  resource_group_name = module.rg_spoke02[0].name
  location            = var.location
  address_space       = local.vnet_config.spoke02.address_space
  subnets             = local.vnet_config.spoke02.subnets
  tags                = local.common_tags

  depends_on = [module.rg_spoke02]
}

# IaC VNet
module "vnet_iac" {
  count = var.create_iac_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.iac.name
  resource_group_name = module.rg_iac[0].name
  location            = var.location
  address_space       = local.vnet_config.iac.address_space
  subnets             = local.vnet_config.iac.subnets
  tags                = local.common_tags

  depends_on = [module.rg_iac]
}

# DNS Private VNet
module "vnet_dns_private" {
  count = var.create_dns_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.dns_private.name
  resource_group_name = module.rg_dns[0].name
  location            = var.location
  address_space       = local.vnet_config.dns_private.address_space
  subnets             = local.vnet_config.dns_private.subnets
  tags                = local.common_tags

  depends_on = [module.rg_dns]
}

# DNS Public VNet
module "vnet_dns_public" {
  count = var.create_dns_resources ? 1 : 0

  source              = "../../modules/virtual-network"
  name                = local.vnet_config.dns_public.name
  resource_group_name = module.rg_dns[0].name
  location            = var.location
  address_space       = local.vnet_config.dns_public.address_space
  subnets             = local.vnet_config.dns_public.subnets
  tags                = local.common_tags

  depends_on = [module.rg_dns]
}

# ==============================================================================
# VNET PEERINGS
# ==============================================================================

# Hub to APM Peering
module "peering_hub_to_apm" {
  count = var.create_hub_resources && var.create_apm_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.hub_to_apm.name
  source_vnet_name              = module.vnet_hub[0].vnet_name
  source_resource_group_name    = module.rg_hub[0].name
  destination_vnet_id           = module.vnet_apm[0].vnet_id
  allow_virtual_network_access  = local.peering_config.hub_to_apm.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.hub_to_apm.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.hub_to_apm.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_apm]
}

module "peering_apm_to_hub" {
  count = var.create_hub_resources && var.create_apm_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.apm_to_hub.name
  source_vnet_name              = module.vnet_apm[0].vnet_name
  source_resource_group_name    = module.rg_apm[0].name
  destination_vnet_id           = module.vnet_hub[0].vnet_id
  allow_virtual_network_access  = local.peering_config.apm_to_hub.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.apm_to_hub.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.apm_to_hub.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_apm]
}

# Hub to Management Peering
module "peering_hub_to_management" {
  count = var.create_hub_resources && var.create_management_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.hub_to_management.name
  source_vnet_name              = module.vnet_hub[0].vnet_name
  source_resource_group_name    = module.rg_hub[0].name
  destination_vnet_id           = module.vnet_management[0].vnet_id
  allow_virtual_network_access  = local.peering_config.hub_to_management.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.hub_to_management.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.hub_to_management.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_management]
}

module "peering_management_to_hub" {
  count = var.create_hub_resources && var.create_management_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.management_to_hub.name
  source_vnet_name              = module.vnet_management[0].vnet_name
  source_resource_group_name    = module.rg_management[0].name
  destination_vnet_id           = module.vnet_hub[0].vnet_id
  allow_virtual_network_access  = local.peering_config.management_to_hub.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.management_to_hub.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.management_to_hub.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_management]
}

# Hub to Spoke01 Peering
module "peering_hub_to_spoke01" {
  count = var.create_hub_resources && var.create_spoke01_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.hub_to_spoke01.name
  source_vnet_name              = module.vnet_hub[0].vnet_name
  source_resource_group_name    = module.rg_hub[0].name
  destination_vnet_id           = module.vnet_spoke01[0].vnet_id
  allow_virtual_network_access  = local.peering_config.hub_to_spoke01.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.hub_to_spoke01.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.hub_to_spoke01.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_spoke01]
}

module "peering_spoke01_to_hub" {
  count = var.create_hub_resources && var.create_spoke01_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.spoke01_to_hub.name
  source_vnet_name              = module.vnet_spoke01[0].vnet_name
  source_resource_group_name    = module.rg_spoke01[0].name
  destination_vnet_id           = module.vnet_hub[0].vnet_id
  allow_virtual_network_access  = local.peering_config.spoke01_to_hub.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.spoke01_to_hub.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.spoke01_to_hub.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_spoke01]
}

# Hub to Spoke02 Peering
module "peering_hub_to_spoke02" {
  count = var.create_hub_resources && var.create_spoke02_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.hub_to_spoke02.name
  source_vnet_name              = module.vnet_hub[0].vnet_name
  source_resource_group_name    = module.rg_hub[0].name
  destination_vnet_id           = module.vnet_spoke02[0].vnet_id
  allow_virtual_network_access  = local.peering_config.hub_to_spoke02.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.hub_to_spoke02.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.hub_to_spoke02.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_spoke02]
}

module "peering_spoke02_to_hub" {
  count = var.create_hub_resources && var.create_spoke02_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.spoke02_to_hub.name
  source_vnet_name              = module.vnet_spoke02[0].vnet_name
  source_resource_group_name    = module.rg_spoke02[0].name
  destination_vnet_id           = module.vnet_hub[0].vnet_id
  allow_virtual_network_access  = local.peering_config.spoke02_to_hub.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.spoke02_to_hub.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.spoke02_to_hub.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_spoke02]
}

# Hub to IaC Peering
module "peering_hub_to_iac" {
  count = var.create_hub_resources && var.create_iac_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.hub_to_iac.name
  source_vnet_name              = module.vnet_hub[0].vnet_name
  source_resource_group_name    = module.rg_hub[0].name
  destination_vnet_id           = module.vnet_iac[0].vnet_id
  allow_virtual_network_access  = local.peering_config.hub_to_iac.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.hub_to_iac.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.hub_to_iac.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_iac]
}

module "peering_iac_to_hub" {
  count = var.create_hub_resources && var.create_iac_resources ? 1 : 0

  source = "../../modules/vnet-peering"

  peering_name                  = local.peering_config.iac_to_hub.name
  source_vnet_name              = module.vnet_iac[0].vnet_name
  source_resource_group_name    = module.rg_iac[0].name
  destination_vnet_id           = module.vnet_hub[0].vnet_id
  allow_virtual_network_access  = local.peering_config.iac_to_hub.allow_virtual_network_access
  allow_forwarded_traffic       = local.peering_config.iac_to_hub.allow_forwarded_traffic
  allow_gateway_transit         = local.peering_config.iac_to_hub.allow_gateway_transit

  depends_on = [module.vnet_hub, module.vnet_iac]
}

# ==============================================================================
# MONITORING & LOG ANALYTICS
# ==============================================================================

# Log Analytics Workspace
module "log_analytics" {
  count = var.create_monitoring ? 1 : 0

  source = "../../modules/log-analytics"

  name                = local.log_analytics_config.name
  resource_group_name = module.rg_governance[0].name
  location            = var.location
  sku                 = local.log_analytics_config.sku
  retention_in_days   = local.log_analytics_config.retention_in_days
  tags                = local.common_tags

  depends_on = [module.rg_governance]
}

# Monitoring Configuration
module "monitoring" {
  count = var.create_monitoring ? 1 : 0

  source = "../../modules/monitoring"

  resource_group_name      = module.rg_governance[0].name
  location                 = var.location
  log_analytics_workspace_id = module.log_analytics[0].workspace_id
  tags                     = local.common_tags

  depends_on = [module.log_analytics]
}

# ==============================================================================
# AZURE BASTION
# ==============================================================================

module "bastion" {
  count = var.create_bastion && var.create_hub_resources ? 1 : 0

  source = "../../modules/bastion"

  name                = local.bastion_config.name
  resource_group_name = module.rg_hub[0].name
  location            = var.location
  subnet_id           = module.vnet_hub[0].subnet_ids["bastion"]
  sku                 = local.bastion_config.sku
  tags                = local.common_tags

  depends_on = [module.vnet_hub]
}

# ==============================================================================
# API MANAGEMENT
# ==============================================================================

module "api_management" {
  count = var.create_api_management && var.create_apm_resources ? 1 : 0

  source = "../../modules/api-management"

  name                = local.apim_config.name
  resource_group_name = module.rg_apm[0].name
  location            = var.location
  sku_name            = local.apim_config.sku_name
  publisher_name      = local.apim_config.publisher_name
  publisher_email     = local.apim_config.publisher_email
  virtual_network_type = "Internal"
  subnet_id           = module.vnet_apm[0].subnet_ids["apm"]
  tags                = local.common_tags

  depends_on = [module.vnet_apm]
}

# ==============================================================================
# APPLICATION GATEWAY
# ==============================================================================

module "application_gateway" {
  count = var.create_application_gateway && var.create_hub_resources ? 1 : 0

  source = "../../modules/application-gateway"

  name                = local.app_gateway_config.name
  resource_group_name = module.rg_hub[0].name
  location            = var.location
  sku_name            = local.app_gateway_config.sku_name
  sku_tier            = local.app_gateway_config.sku_tier
  sku_capacity        = local.app_gateway_config.sku_capacity
  subnet_id           = module.vnet_hub[0].subnet_ids["application_gateway"]
  public_ip_name      = local.app_gateway_config.public_ip_name
  tags                = local.common_tags

  depends_on = [module.vnet_hub]
}

# ==============================================================================
# PRIVATE DNS ZONES
# ==============================================================================

module "private_dns_zones" {
  count = var.create_dns_resources ? 1 : 0

  source = "../../modules/private-dns-zone"

  dns_zones           = local.private_dns_zones
  resource_group_name = module.rg_dns[0].name
  vnet_links = {
    hub = {
      vnet_id   = module.vnet_hub[0].vnet_id
      vnet_name = module.vnet_hub[0].vnet_name
    }
  }
  tags = local.common_tags

  depends_on = [module.rg_dns, module.vnet_hub]
}

# ==============================================================================
# DNS RESOLVER
# ==============================================================================

module "dns_resolver" {
  count = var.create_dns_resources ? 1 : 0

  source = "../../modules/dns-resolver"

  name                = local.dns_resolver_config.name
  resource_group_name = module.rg_dns[0].name
  location            = var.location
  virtual_network_id  = module.vnet_dns_private[0].vnet_id
  inbound_subnet_id   = module.vnet_dns_private[0].subnet_ids["dns_private"]
  tags                = local.common_tags

  depends_on = [module.vnet_dns_private]
}

# ==============================================================================
# VIRTUAL MACHINES
# ==============================================================================

# Bastion VM in Management VNet
module "vm_bastion_mgmt" {
  count = var.create_management_resources ? 1 : 0

  source = "../../modules/virtual-machine"

  name                = local.vm_config.bastion_mgmt.name
  resource_group_name = module.rg_management[0].name
  location            = var.location
  size                = local.vm_config.bastion_mgmt.size
  admin_username      = local.vm_config.bastion_mgmt.admin_username
  admin_password      = var.vm_admin_password
  subnet_id           = module.vnet_management[0].subnet_ids["management"]
  tags                = local.common_tags

  depends_on = [module.vnet_management]
}

# Bastion VM in APM VNet
module "vm_bastion_apm" {
  count = var.create_apm_resources ? 1 : 0

  source = "../../modules/virtual-machine"

  name                = local.vm_config.bastion_apm.name
  resource_group_name = module.rg_apm[0].name
  location            = var.location
  size                = local.vm_config.bastion_apm.size
  admin_username      = local.vm_config.bastion_apm.admin_username
  admin_password      = var.vm_admin_password
  subnet_id           = module.vnet_apm[0].subnet_ids["apm"]
  tags                = local.common_tags

  depends_on = [module.vnet_apm]
}

# Agent VM in IaC VNet
module "vm_agent" {
  count = var.create_iac_resources ? 1 : 0

  source = "../../modules/virtual-machine"

  name                = local.vm_config.agent.name
  resource_group_name = module.rg_iac[0].name
  location            = var.location
  size                = local.vm_config.agent.size
  admin_username      = local.vm_config.agent.admin_username
  admin_password      = var.vm_admin_password
  subnet_id           = module.vnet_iac[0].subnet_ids["agent_vm"]
  tags                = local.common_tags

  depends_on = [module.vnet_iac]
}

# ==============================================================================
# STORAGE ACCOUNT (Terraform State)
# ==============================================================================

module "storage_tfstate" {
  count = var.create_iac_resources ? 1 : 0

  source = "../../modules/storage-account"

  name                = local.tfstate_storage_config.name
  resource_group_name = module.rg_iac[0].name
  location            = var.location
  account_tier        = local.tfstate_storage_config.account_tier
  replication_type    = local.tfstate_storage_config.replication_type
  container_name      = local.tfstate_storage_config.container_name
  tags                = local.common_tags

  depends_on = [module.rg_iac]
}

# ==============================================================================
# SQL DATABASE
# ==============================================================================

module "sql_database" {
  count = var.create_spoke02_resources ? 1 : 0

  source = "../../modules/sql-database"

  server_name         = local.sql_config.server_name
  database_name       = local.sql_config.database_name
  resource_group_name = module.rg_spoke02[0].name
  location            = var.location
  admin_username      = local.sql_config.admin_username
  admin_password      = var.sql_admin_password
  sku_name            = local.sql_config.sku_name
  tags                = local.common_tags

  depends_on = [module.rg_spoke02]
}

# ==============================================================================
# FUNCTION APP
# ==============================================================================

module "function_app" {
  count = var.create_spoke02_resources ? 1 : 0

  source = "../../modules/function-app"

  name                   = local.function_app_config.name
  resource_group_name    = module.rg_spoke02[0].name
  location               = var.location
  storage_account_name   = local.function_app_config.storage_account
  service_plan_name      = local.function_app_config.service_plan_name
  runtime_stack          = local.function_app_config.runtime
  runtime_version        = local.function_app_config.version
  subnet_id              = module.vnet_spoke02[0].subnet_ids["integration"]
  tags                   = local.common_tags

  depends_on = [module.rg_spoke02, module.vnet_spoke02]
}

# ==============================================================================
# PRIVATE ENDPOINTS
# ==============================================================================

# Private Endpoint for SQL Database
module "pe_sql_database" {
  count = var.create_spoke02_resources ? 1 : 0

  source = "../../modules/private-endpoint"

  name                = "pe-sql-${var.project}-${var.environment}-${var.location_short}-001"
  resource_group_name = module.rg_spoke02[0].name
  location            = var.location
  subnet_id           = module.vnet_spoke02[0].subnet_ids["db_pe"]
  private_connection_resource_id = module.sql_database[0].sql_server_id
  subresource_names   = ["sqlServer"]
  tags                = local.common_tags

  depends_on = [module.sql_database, module.vnet_spoke02]
}

# Private Endpoint for Function App
module "pe_function_app" {
  count = var.create_spoke02_resources ? 1 : 0

  source = "../../modules/private-endpoint"

  name                = "pe-func-${var.project}-${var.environment}-${var.location_short}-001"
  resource_group_name = module.rg_spoke02[0].name
  location            = var.location
  subnet_id           = module.vnet_spoke02[0].subnet_ids["app_pe"]
  private_connection_resource_id = module.function_app[0].function_app_id
  subresource_names   = ["sites"]
  tags                = local.common_tags

  depends_on = [module.function_app, module.vnet_spoke02]
}

# Private Endpoint for Terraform State Storage
module "pe_tfstate_storage" {
  count = var.create_iac_resources ? 1 : 0

  source = "../../modules/private-endpoint"

  name                = "pe-st-${var.project}-${var.environment}-${var.location_short}-001"
  resource_group_name = module.rg_iac[0].name
  location            = var.location
  subnet_id           = module.vnet_iac[0].subnet_ids["agent_vm"]
  private_connection_resource_id = module.storage_tfstate[0].storage_account_id
  subresource_names   = ["blob"]
  tags                = local.common_tags

  depends_on = [module.storage_tfstate, module.vnet_iac]
}
