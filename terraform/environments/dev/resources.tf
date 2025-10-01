# ============================================================================
# RESOURCE GROUPS
# ============================================================================

module "resource_groups" {
  source   = "../../modules/management/resource-groups"
  for_each = local.create_resource_groups ? local.resource_groups : {}

  name     = each.value.name
  location = each.value.location
  tags     = each.value.tags
}

# ============================================================================
# LOG ANALYTICS WORKSPACE
# ============================================================================

module "log_analytics" {
  source = "../../modules/management/log-analytics"
  count  = local.create_log_analytics ? 1 : 0

  name                = local.log_analytics.name
  resource_group_name = local.log_analytics.resource_group_name
  location            = local.log_analytics.location
  sku                 = local.log_analytics.sku
  retention_in_days   = local.log_analytics.retention_in_days
  tags                = local.log_analytics.tags

  depends_on = [module.resource_groups]
}

# ============================================================================
# VIRTUAL NETWORKS
# ============================================================================

module "virtual_networks" {
  source   = "../../modules/network/virtual-network"
  for_each = local.vnets

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = each.value.tags

  depends_on = [module.resource_groups]
}

# ============================================================================
# VNET PEERINGS (Hub-Spoke topology)
# ============================================================================

module "vnet_peering_hub_to_apim" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_apim_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-apim"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["apim"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_apim_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_apim_vnet ? 1 : 0

  peering_name                     = "peer-apim-to-hub"
  resource_group_name              = local.resource_groups.apim.name
  virtual_network_name             = local.vnets.apim.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_hub_to_mgmt" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_mgmt_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-mgmt"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["mgmt"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_mgmt_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_mgmt_vnet ? 1 : 0

  peering_name                     = "peer-mgmt-to-hub"
  resource_group_name              = local.resource_groups.mgmt.name
  virtual_network_name             = local.vnets.mgmt.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_hub_to_spoke01" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_spoke01_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-spoke01"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["spoke01"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_spoke01_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_spoke01_vnet ? 1 : 0

  peering_name                     = "peer-spoke01-to-hub"
  resource_group_name              = local.resource_groups.spoke01.name
  virtual_network_name             = local.vnets.spoke01.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_hub_to_spoke02" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_spoke02_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-spoke02"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["spoke02"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_spoke02_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_spoke02_vnet ? 1 : 0

  peering_name                     = "peer-spoke02-to-hub"
  resource_group_name              = local.resource_groups.spoke02.name
  virtual_network_name             = local.vnets.spoke02.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_hub_to_iac" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_iac_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-iac"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["iac"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_iac_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_iac_vnet ? 1 : 0

  peering_name                     = "peer-iac-to-hub"
  resource_group_name              = local.resource_groups.iac.name
  virtual_network_name             = local.vnets.iac.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_hub_to_dns" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_dns_vnet ? 1 : 0

  peering_name                     = "peer-hub-to-dns"
  resource_group_name              = local.resource_groups.hub.name
  virtual_network_name             = local.vnets.hub.name
  remote_virtual_network_id        = module.virtual_networks["dns"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = true
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

module "vnet_peering_dns_to_hub" {
  source = "../../modules/network/vnet-peering"
  count  = local.create_vnet_peerings && local.create_hub_vnet && local.create_dns_vnet ? 1 : 0

  peering_name                     = "peer-dns-to-hub"
  resource_group_name              = local.resource_groups.dns.name
  virtual_network_name             = local.vnets.dns.name
  remote_virtual_network_id        = module.virtual_networks["hub"].vnet_id
  allow_virtual_network_access     = true
  allow_forwarded_traffic          = true
  allow_gateway_transit            = false
  use_remote_gateways              = false

  depends_on = [module.virtual_networks]
}

# ============================================================================
# PRIVATE DNS ZONES
# ============================================================================

module "private_dns_zones" {
  source   = "../../modules/network/private-dns-zones"
  for_each = local.create_private_dns_zones ? local.private_dns_zones : {}

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
  vnet_links = {
    hub = {
      vnet_id = module.virtual_networks["hub"].vnet_id
    }
  }

  depends_on = [module.resource_groups, module.virtual_networks]
}

# ============================================================================
# DNS RESOLVER
# ============================================================================

module "dns_resolver" {
  source = "../../modules/network/dns-resolver"
  count  = local.create_dns_resolver ? 1 : 0

  name                = local.dns_resolver.name
  resource_group_name = local.dns_resolver.resource_group_name
  location            = local.dns_resolver.location
  virtual_network_id  = module.virtual_networks["dns"].vnet_id
  inbound_subnet_id   = module.virtual_networks["dns"].subnet_ids["inbound"]
  outbound_subnet_id  = module.virtual_networks["dns"].subnet_ids["outbound"]
  tags                = local.dns_resolver.tags

  depends_on = [module.virtual_networks]
}

# ============================================================================
# AZURE FIREWALL
# ============================================================================

module "azure_firewall" {
  source = "../../modules/security/azure-firewall"
  count  = local.create_azure_firewall ? 1 : 0

  name                = local.azure_firewall.name
  resource_group_name = local.azure_firewall.resource_group_name
  location            = local.azure_firewall.location
  sku_name            = local.azure_firewall.sku_name
  sku_tier            = local.azure_firewall.sku_tier
  subnet_id           = module.virtual_networks["hub"].subnet_ids["firewall"]
  tags                = local.azure_firewall.tags

  depends_on = [module.virtual_networks, module.log_analytics]
}

# ============================================================================
# APPLICATION GATEWAY
# ============================================================================

module "application_gateway" {
  source = "../../modules/security/application-gateway"
  count  = local.create_application_gateway ? 1 : 0

  name                = local.application_gateway.name
  resource_group_name = local.application_gateway.resource_group_name
  location            = local.application_gateway.location
  sku_name            = local.application_gateway.sku_name
  sku_tier            = local.application_gateway.sku_tier
  sku_capacity        = local.application_gateway.sku_capacity
  subnet_id           = module.virtual_networks["hub"].subnet_ids["appgateway"]
  tags                = local.application_gateway.tags

  depends_on = [module.virtual_networks]
}

# ============================================================================
# AZURE BASTION
# ============================================================================

module "azure_bastion" {
  source = "../../modules/security/bastion"
  count  = local.create_azure_bastion ? 1 : 0

  name                = local.azure_bastion.name
  resource_group_name = local.azure_bastion.resource_group_name
  location            = local.azure_bastion.location
  sku                 = local.azure_bastion.sku
  subnet_id           = module.virtual_networks["hub"].subnet_ids["bastion"]
  tags                = local.azure_bastion.tags

  depends_on = [module.virtual_networks]
}

# ============================================================================
# API MANAGEMENT
# ============================================================================

module "api_management" {
  source = "../../modules/integration/api-management"
  count  = local.create_api_management ? 1 : 0

  name                = local.api_management.name
  resource_group_name = local.api_management.resource_group_name
  location            = local.api_management.location
  publisher_name      = local.api_management.publisher_name
  publisher_email     = local.api_management.publisher_email
  sku_name            = local.api_management.sku_name
  subnet_id           = module.virtual_networks["apim"].subnet_ids["apim"]
  tags                = local.api_management.tags

  depends_on = [module.virtual_networks]
}

# ============================================================================
# STORAGE ACCOUNTS
# ============================================================================

module "storage_accounts" {
  source   = "../../modules/data/storage-account"
  for_each = local.create_storage_account ? local.storage_accounts : {}

  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = each.value.tags

  depends_on = [module.resource_groups]
}

# ============================================================================
# SQL DATABASE
# ============================================================================

module "sql_database" {
  source = "../../modules/data/sql-database"
  count  = local.create_sql_database ? 1 : 0

  server_name                      = local.sql_server.name
  resource_group_name              = local.sql_server.resource_group_name
  location                         = local.sql_server.location
  sql_version                      = local.sql_server.version
  administrator_login              = local.sql_server.administrator_login
  public_network_access_enabled    = local.sql_server.public_network_access_enabled
  database_name                    = local.sql_database.name
  database_sku_name                = local.sql_database.sku_name
  tags                             = local.sql_server.tags

  depends_on = [module.resource_groups]
}

# ============================================================================
# FUNCTION APP
# ============================================================================

module "function_app" {
  source = "../../modules/compute/function-app"
  count  = local.create_function_app ? 1 : 0

  name                   = local.function_app.name
  resource_group_name    = local.function_app.resource_group_name
  location               = local.function_app.location
  storage_account_name   = local.storage_accounts.function.name
  storage_account_key    = module.storage_accounts["function"].primary_access_key
  runtime                = local.function_app.runtime
  subnet_id              = module.virtual_networks["spoke02"].subnet_ids["integration"]
  tags                   = local.function_app.tags

  depends_on = [module.storage_accounts, module.virtual_networks]
}

# ============================================================================
# VIRTUAL MACHINES
# ============================================================================

module "bastion_vm" {
  source = "../../modules/compute/virtual-machines"
  count  = local.create_bastion_vm ? 1 : 0

  name                = local.virtual_machines.bastion_vm.name
  resource_group_name = local.virtual_machines.bastion_vm.resource_group_name
  location            = local.virtual_machines.bastion_vm.location
  size                = local.virtual_machines.bastion_vm.size
  admin_username      = local.virtual_machines.bastion_vm.admin_username
  os_type             = local.virtual_machines.bastion_vm.os_type
  subnet_id           = module.virtual_networks["mgmt"].subnet_ids["mgmt"]
  tags                = local.virtual_machines.bastion_vm.tags

  depends_on = [module.virtual_networks]
}

module "agent_vm" {
  source = "../../modules/compute/virtual-machines"
  count  = local.create_agent_vm ? 1 : 0

  name                = local.virtual_machines.agent_vm.name
  resource_group_name = local.virtual_machines.agent_vm.resource_group_name
  location            = local.virtual_machines.agent_vm.location
  size                = local.virtual_machines.agent_vm.size
  admin_username      = local.virtual_machines.agent_vm.admin_username
  os_type             = local.virtual_machines.agent_vm.os_type
  subnet_id           = module.virtual_networks["iac"].subnet_ids["vm"]
  tags                = local.virtual_machines.agent_vm.tags

  depends_on = [module.virtual_networks]
}

# ============================================================================
# PRIVATE ENDPOINTS
# ============================================================================

module "private_endpoint_sql" {
  source = "../../modules/integration/private-endpoints"
  count  = local.create_private_endpoints && local.create_sql_database ? 1 : 0

  name                = "pe-${local.sql_server.name}"
  resource_group_name = local.sql_server.resource_group_name
  location            = local.sql_server.location
  subnet_id           = module.virtual_networks["spoke02"].subnet_ids["dbvpe"]
  private_connection_resource_id = module.sql_database[0].sql_server_id
  subresource_names   = ["sqlServer"]
  private_dns_zone_ids = [module.private_dns_zones["sql"].dns_zone_id]
  tags                = local.sql_server.tags

  depends_on = [module.sql_database, module.private_dns_zones]
}

module "private_endpoint_storage_tfstate" {
  source = "../../modules/integration/private-endpoints"
  count  = local.create_private_endpoints && local.create_storage_account ? 1 : 0

  name                = "pe-${local.storage_accounts.tfstate.name}"
  resource_group_name = local.storage_accounts.tfstate.resource_group_name
  location            = local.storage_accounts.tfstate.location
  subnet_id           = module.virtual_networks["iac"].subnet_ids["pe"]
  private_connection_resource_id = module.storage_accounts["tfstate"].storage_account_id
  subresource_names   = ["blob"]
  private_dns_zone_ids = [module.private_dns_zones["blob"].dns_zone_id]
  tags                = local.storage_accounts.tfstate.tags

  depends_on = [module.storage_accounts, module.private_dns_zones]
}

module "private_endpoint_function_app" {
  source = "../../modules/integration/private-endpoints"
  count  = local.create_private_endpoints && local.create_function_app ? 1 : 0

  name                = "pe-${local.function_app.name}"
  resource_group_name = local.function_app.resource_group_name
  location            = local.function_app.location
  subnet_id           = module.virtual_networks["spoke02"].subnet_ids["apppe"]
  private_connection_resource_id = module.function_app[0].function_app_id
  subresource_names   = ["sites"]
  private_dns_zone_ids = [module.private_dns_zones["sites"].dns_zone_id]
  tags                = local.function_app.tags

  depends_on = [module.function_app, module.private_dns_zones]
}

# ============================================================================
# MONITORING AND GOVERNANCE
# ============================================================================

module "monitoring" {
  source = "../../modules/management/monitoring"
  count  = local.create_monitoring ? 1 : 0

  resource_group_name       = local.monitoring.resource_group_name
  location                  = local.monitoring.location
  log_analytics_workspace_id = local.create_log_analytics ? module.log_analytics[0].workspace_id : null
  tags                      = local.monitoring.tags

  depends_on = [module.resource_groups, module.log_analytics]
}
