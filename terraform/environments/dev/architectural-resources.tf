# ============================================================================
# CONTOSO ARCHITECTURE RESOURCES - CENTRAL DEPLOYMENT FILE
# ============================================================================
# This file contains all the resources for the Contoso architecture
# Each resource can be conditionally deployed using the enable_* variables

# ============================================================================
# RESOURCE GROUPS
# ============================================================================

resource "azurerm_resource_group" "hub_rg" {
  count    = var.deploy_hub_network ? 1 : 0
  name     = "rg-${var.project_name}-hub-${var.environment}-${local.location_short}-${local.name_suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "spoke_app_rg" {
  count    = var.deploy_spoke_app_network ? 1 : 0
  name     = "rg-${var.project_name}-app-${var.environment}-${local.location_short}-${local.name_suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "spoke_data_rg" {
  count    = var.deploy_spoke_data_network ? 1 : 0
  name     = "rg-${var.project_name}-data-${var.environment}-${local.location_short}-${local.name_suffix}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_resource_group" "management_rg" {
  count    = var.deploy_management_resources ? 1 : 0
  name     = "rg-${var.project_name}-mgmt-${var.environment}-${local.location_short}-${local.name_suffix}"
  location = var.location
  tags     = local.common_tags
}

# ============================================================================
# HUB VIRTUAL NETWORK
# ============================================================================

module "hub_vnet" {
  count  = var.deploy_hub_network ? 1 : 0
  source = "../../modules/networking/hub-vnet"

  location                        = var.location
  vnet_name                      = "vnet-${var.project_name}-hub-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name            = azurerm_resource_group.hub_rg[0].name
  address_space                  = [var.hub_vnet_address_space]
  gateway_subnet_prefix          = var.hub_gateway_subnet_prefix
  firewall_subnet_prefix         = var.hub_firewall_subnet_prefix
  shared_services_subnet_prefix  = var.hub_shared_services_subnet_prefix
  environment                    = var.environment
  location_short                 = local.location_short
  tags                          = local.common_tags

  depends_on = [azurerm_resource_group.hub_rg]
}

# ============================================================================
# SPOKE VIRTUAL NETWORKS
# ============================================================================

# Application Tier Spoke VNet
module "spoke_app_vnet" {
  count  = var.deploy_spoke_app_network ? 1 : 0
  source = "../../modules/networking/spoke-vnet"

  location            = var.location
  vnet_name          = "vnet-${var.project_name}-app-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  address_space      = [var.spoke_app_vnet_address_space]
  
  subnets = {
    web_tier = {
      name             = "snet-web-${var.environment}-${local.location_short}-${local.name_suffix}"
      address_prefixes = [var.spoke_app_web_subnet_prefix]
    }
    app_tier = {
      name             = "snet-app-${var.environment}-${local.location_short}-${local.name_suffix}"
      address_prefixes = [var.spoke_app_app_subnet_prefix]
    }
    private_endpoints = {
      name             = "snet-pe-${var.environment}-${local.location_short}-${local.name_suffix}"
      address_prefixes = [var.spoke_app_pe_subnet_prefix]
    }
  }
  
  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_app_rg]
}

# Data Tier Spoke VNet
module "spoke_data_vnet" {
  count  = var.deploy_spoke_data_network ? 1 : 0
  source = "../../modules/networking/spoke-vnet"

  location            = var.location
  vnet_name          = "vnet-${var.project_name}-data-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.spoke_data_rg[0].name
  address_space      = [var.spoke_data_vnet_address_space]
  
  subnets = {
    database = {
      name             = "snet-db-${var.environment}-${local.location_short}-${local.name_suffix}"
      address_prefixes = [var.spoke_data_db_subnet_prefix]
    }
    storage = {
      name             = "snet-storage-${var.environment}-${local.location_short}-${local.name_suffix}"
      address_prefixes = [var.spoke_data_storage_subnet_prefix]
    }
  }
  
  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_data_rg]
}

# ============================================================================
# VNET PEERING
# ============================================================================

# Hub to App Spoke Peering
module "hub_to_app_peering" {
  count  = var.deploy_hub_network && var.deploy_spoke_app_network ? 1 : 0
  source = "../../modules/networking/vnet-peering"

  hub_vnet_name               = module.hub_vnet[0].vnet_name
  spoke_vnet_name            = module.spoke_app_vnet[0].vnet_name
  hub_resource_group_name    = azurerm_resource_group.hub_rg[0].name
  spoke_resource_group_name  = azurerm_resource_group.spoke_app_rg[0].name
  hub_vnet_id               = module.hub_vnet[0].vnet_id
  spoke_vnet_id             = module.spoke_app_vnet[0].vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  use_remote_gateways       = false

  depends_on = [module.hub_vnet, module.spoke_app_vnet]
}

# Hub to Data Spoke Peering
module "hub_to_data_peering" {
  count  = var.deploy_hub_network && var.deploy_spoke_data_network ? 1 : 0
  source = "../../modules/networking/vnet-peering"

  hub_vnet_name               = module.hub_vnet[0].vnet_name
  spoke_vnet_name            = module.spoke_data_vnet[0].vnet_name
  hub_resource_group_name    = azurerm_resource_group.hub_rg[0].name
  spoke_resource_group_name  = azurerm_resource_group.spoke_data_rg[0].name
  hub_vnet_id               = module.hub_vnet[0].vnet_id
  spoke_vnet_id             = module.spoke_data_vnet[0].vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  use_remote_gateways       = false

  depends_on = [module.hub_vnet, module.spoke_data_vnet]
}

# ============================================================================
# APP SERVICE PLAN
# ============================================================================

resource "azurerm_service_plan" "app_service_plan" {
  count               = var.deploy_app_services ? 1 : 0
  name                = "plan-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  os_type            = "Linux"
  sku_name           = var.app_service_plan_sku

  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_app_rg]
}

# ============================================================================
# STORAGE ACCOUNTS
# ============================================================================

module "primary_storage" {
  count  = var.deploy_storage_accounts ? 1 : 0
  source = "../../modules/data/storage-account"

  location                = var.location
  storage_account_name    = "st${var.project_name}${var.environment}${local.location_short}${local.name_suffix}"
  resource_group_name     = azurerm_resource_group.spoke_data_rg[0].name
  account_tier           = var.storage_account_tier
  replication_type       = var.storage_replication_type
  network_rules_enabled  = var.storage_network_rules_enabled
  blob_retention_days    = var.blob_retention_days
  blob_versioning_enabled = var.blob_versioning_enabled
  tags                   = local.common_tags

  depends_on = [azurerm_resource_group.spoke_data_rg]
}

# ============================================================================
# VIRTUAL MACHINES
# ============================================================================

# Web Tier VM
module "web_vm" {
  count  = var.deploy_web_vms ? 1 : 0
  source = "../../modules/compute/virtual-machines"

  location            = var.location
  vm_name            = "vm-web-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  admin_username     = var.vm_admin_username
  os_type           = "Linux"
  vm_size           = var.web_vm_size
  zone              = "1"
  subnet_id         = module.spoke_app_vnet[0].subnets["web_tier"].resource_id
  tags              = local.common_tags

  depends_on = [module.spoke_app_vnet]
}

# App Tier VM
module "app_vm" {
  count  = var.deploy_app_vms ? 1 : 0
  source = "../../modules/compute/virtual-machines"

  location            = var.location
  vm_name            = "vm-app-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  admin_username     = var.vm_admin_username
  os_type           = "Linux"
  vm_size           = var.app_vm_size
  zone              = "2"
  subnet_id         = module.spoke_app_vnet[0].subnets["app_tier"].resource_id
  tags              = local.common_tags

  depends_on = [module.spoke_app_vnet]
}

# ============================================================================
# WEB APPLICATIONS
# ============================================================================

# Web App Service
module "web_app" {
  count  = var.deploy_app_services ? 1 : 0
  source = "../../modules/compute/app-service"

  location                = var.location
  app_service_name       = "app-${var.project_name}-web-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name    = azurerm_resource_group.spoke_app_rg[0].name
  service_plan_id        = azurerm_service_plan.app_service_plan[0].id
  always_on             = var.environment != "dev"
  tags                  = local.common_tags

  depends_on = [azurerm_service_plan.app_service_plan]
}

# ============================================================================
# AZURE FRONT DOOR
# ============================================================================

module "front_door" {
  count  = var.deploy_front_door ? 1 : 0
  source = "../../modules/networking/front-door"

  front_door_name     = "fd-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  location           = var.location
  front_door_sku     = var.front_door_sku
  enable_waf         = var.enable_waf
  waf_mode          = var.waf_mode

  backend_origins = var.deploy_app_services ? [{
    host_name                = module.web_app[0].app_service_default_hostname
    priority                 = 1
    weight                  = 1000
    private_link_target_type = "sites"
    private_link_target_id   = module.web_app[0].app_service_id
  }] : []

  health_probe_path = var.front_door_health_probe_path
  tags             = local.common_tags

  depends_on = [module.web_app, azurerm_resource_group.spoke_app_rg]
}

# ============================================================================
# SECURITY RESOURCES
# ============================================================================

# Key Vault
module "key_vault" {
  count  = var.deploy_key_vault ? 1 : 0
  source = "../../modules/security/key-vault"

  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  key_vault_name     = "kv-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  tenant_id          = data.azurerm_client_config.current.tenant_id

  tags = local.common_tags

  depends_on = [azurerm_resource_group.shared_rg]
}

# Network Security Groups
module "hub_nsg" {
  count  = var.deploy_hub_vnet == 1 && var.deploy_network_security_groups ? 1 : 0
  source = "../../modules/security/network-security-group"

  location            = var.location
  resource_group_name = azurerm_resource_group.hub_rg[0].name
  nsg_name           = "nsg-hub-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"

  security_rules = var.hub_nsg_rules

  tags = local.common_tags

  depends_on = [azurerm_resource_group.hub_rg]
}

module "app_spoke_nsg" {
  count  = var.deploy_spoke_vnets == 1 && var.deploy_network_security_groups ? 1 : 0
  source = "../../modules/security/network-security-group"

  location            = var.location
  resource_group_name = azurerm_resource_group.spoke_app_rg[0].name
  nsg_name           = "nsg-app-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"

  security_rules = var.app_spoke_nsg_rules

  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_app_rg]
}

module "data_spoke_nsg" {
  count  = var.deploy_spoke_vnets == 1 && var.deploy_network_security_groups ? 1 : 0
  source = "../../modules/security/network-security-group"

  location            = var.location
  resource_group_name = azurerm_resource_group.spoke_data_rg[0].name
  nsg_name           = "nsg-data-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"

  security_rules = var.data_spoke_nsg_rules

  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_data_rg]
}

# ============================================================================
# DATA RESOURCES
# ============================================================================

# SQL Database
module "sql_database" {
  count  = var.deploy_sql_database ? 1 : 0
  source = "../../modules/data/sql-database"

  location               = var.location
  resource_group_name    = var.deploy_spoke_vnets == 1 ? azurerm_resource_group.spoke_data_rg[0].name : azurerm_resource_group.shared_rg.name
  sql_server_name       = "sql-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  database_name         = "sqldb-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  
  # Authentication
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
  server_version              = var.sql_server_version
  
  # Azure AD Admin (optional)
  azuread_administrator = var.sql_azuread_administrator
  
  # Firewall rules
  firewall_rules = var.sql_firewall_rules
  
  # Database configuration
  database_sku           = var.sql_database_sku
  max_size_gb           = var.sql_database_max_size_gb
  backup_retention_days = var.sql_backup_retention_days
  
  # Long-term retention
  enable_long_term_retention = var.sql_enable_long_term_retention
  weekly_retention          = var.sql_weekly_retention
  monthly_retention         = var.sql_monthly_retention
  yearly_retention          = var.sql_yearly_retention

  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_data_rg]
}

# ============================================================================
# MONITORING RESOURCES
# ============================================================================

# Log Analytics Workspace
module "log_analytics" {
  count  = var.deploy_log_analytics ? 1 : 0
  source = "../../modules/monitoring/log-analytics"

  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  workspace_name     = "log-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"

  tags = local.common_tags

  depends_on = [azurerm_resource_group.shared_rg]
}

# Application Insights
module "application_insights" {
  count  = var.deploy_application_insights ? 1 : 0
  source = "../../modules/monitoring/application-insights"

  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  app_insights_name  = "appi-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  workspace_id       = var.deploy_log_analytics ? module.log_analytics[0].workspace_id : null
  
  # Configuration
  application_type    = var.application_insights_type
  retention_in_days   = var.application_insights_retention_days
  
  tags = local.common_tags

  depends_on = [
    azurerm_resource_group.shared_rg,
    module.log_analytics
  ]
}

# ============================================================================
# CONTAINER RESOURCES
# ============================================================================

# Container Instances
module "container_instances" {
  count  = var.deploy_container_instances ? 1 : 0
  source = "../../modules/compute/container-instances"

  location             = var.location
  resource_group_name  = azurerm_resource_group.spoke_app_rg[0].name
  container_group_name = "ci-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  
  # Container configuration
  os_type          = var.container_os_type
  restart_policy   = var.container_restart_policy
  ip_address_type  = var.container_ip_address_type
  
  # Containers
  containers = var.containers

  tags = local.common_tags

  depends_on = [azurerm_resource_group.spoke_app_rg]
}

# ============================================================================
# BACKUP RESOURCES
# ============================================================================

# Recovery Services Vault
module "backup_vault" {
  count  = var.deploy_backup_vault ? 1 : 0
  source = "../../modules/backup/recovery-services-vault"

  location            = var.location
  resource_group_name = azurerm_resource_group.shared_rg.name
  vault_name         = "rsv-${var.project_name}-${var.environment}-${local.location_short}-${local.name_suffix}"
  
  # Vault configuration
  vault_sku                    = var.backup_vault_sku
  soft_delete_enabled         = var.backup_soft_delete_enabled
  cross_region_restore_enabled = var.backup_cross_region_restore_enabled
  storage_mode_type           = var.backup_storage_mode_type
  
  # VM Backup Policy
  enable_vm_backup        = var.enable_vm_backup_policy
  vm_backup_policy_name   = "vm-backup-policy-${var.project_name}-${var.environment}"
  backup_frequency        = var.vm_backup_frequency
  backup_time            = var.vm_backup_time
  daily_retention_count   = var.vm_daily_retention_count
  weekly_retention_count  = var.vm_weekly_retention_count
  monthly_retention_count = var.vm_monthly_retention_count
  yearly_retention_count  = var.vm_yearly_retention_count
  
  # File Share Backup Policy
  enable_file_share_backup              = var.enable_file_share_backup_policy
  file_share_backup_policy_name        = "fs-backup-policy-${var.project_name}-${var.environment}"
  file_share_backup_frequency          = var.file_share_backup_frequency
  file_share_daily_retention_count     = var.file_share_daily_retention_count

  tags = local.common_tags

  depends_on = [azurerm_resource_group.shared_rg]
}