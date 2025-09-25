# Outputs for Contoso Ltd Terraform Configuration

# =============================================================================
# RESOURCE GROUP OUTPUTS
# =============================================================================

output "resource_groups" {
  description = "Resource group information"
  value = {
    hub_rg        = var.deploy_hub_network ? azurerm_resource_group.hub_rg[0].name : null
    spoke_app_rg  = var.deploy_spoke_app_network ? azurerm_resource_group.spoke_app_rg[0].name : null
    spoke_data_rg = var.deploy_spoke_data_network ? azurerm_resource_group.spoke_data_rg[0].name : null
    management_rg = var.deploy_management_resources ? azurerm_resource_group.management_rg[0].name : null
  }
}

# =============================================================================
# NETWORKING OUTPUTS
# =============================================================================

output "virtual_networks" {
  description = "Virtual network information"
  value = {
    hub_vnet_id        = var.deploy_hub_network ? module.hub_vnet[0].vnet_id : null
    spoke_app_vnet_id  = var.deploy_spoke_app_network ? module.spoke_app_vnet[0].vnet_id : null
    spoke_data_vnet_id = var.deploy_spoke_data_network ? module.spoke_data_vnet[0].vnet_id : null
  }
}

output "subnets" {
  description = "Subnet information"
  value = {
    hub_gateway_subnet          = var.deploy_hub_network ? module.hub_vnet[0].gateway_subnet_id : null
    hub_firewall_subnet         = var.deploy_hub_network ? module.hub_vnet[0].firewall_subnet_id : null
    hub_shared_services_subnet  = var.deploy_hub_network ? module.hub_vnet[0].shared_services_subnet_id : null
    spoke_app_web_subnet        = var.deploy_spoke_app_network ? module.spoke_app_vnet[0].subnets["web_tier"].resource_id : null
    spoke_app_app_subnet        = var.deploy_spoke_app_network ? module.spoke_app_vnet[0].subnets["app_tier"].resource_id : null
    spoke_app_pe_subnet         = var.deploy_spoke_app_network ? module.spoke_app_vnet[0].subnets["private_endpoints"].resource_id : null
    spoke_data_db_subnet        = var.deploy_spoke_data_network ? module.spoke_data_vnet[0].subnets["database"].resource_id : null
    spoke_data_storage_subnet   = var.deploy_spoke_data_network ? module.spoke_data_vnet[0].subnets["storage"].resource_id : null
  }
}

# =============================================================================
# COMPUTE OUTPUTS
# =============================================================================

output "virtual_machines" {
  description = "Virtual machine information"
  value = var.deploy_virtual_machines == 1 ? {
    web_vm_ids  = module.web_vms[0].vm_ids
    app_vm_ids  = module.app_vms[0].vm_ids
    data_vm_ids = module.data_vms[0].vm_ids
  } : null
  sensitive = true
}

output "app_services" {
  description = "App Service information"
  value = var.deploy_app_services == 1 ? {
    web_app_url    = module.web_app[0].app_service_default_site_hostname
    api_app_url    = module.api_app[0].app_service_default_site_hostname
    web_app_id     = module.web_app[0].app_service_id
    api_app_id     = module.api_app[0].app_service_id
  } : null
}

# =============================================================================
# DATA OUTPUTS
# =============================================================================

output "sql_database" {
  description = "SQL Database information"
  value = var.deploy_sql_database == 1 ? {
    server_fqdn   = module.sql_database[0].sql_server_fqdn
    database_name = module.sql_database[0].sql_database_name
    server_id     = module.sql_database[0].sql_server_id
  } : null
}

output "storage_accounts" {
  description = "Storage Account information"
  value = var.deploy_storage_accounts == 1 ? {
    primary_blob_endpoint = module.storage_accounts[0].primary_blob_endpoint
    primary_web_endpoint  = module.storage_accounts[0].primary_web_endpoint
    storage_account_name  = module.storage_accounts[0].storage_account_name
  } : null
}

# =============================================================================
# SECURITY OUTPUTS
# =============================================================================

output "key_vault" {
  description = "Key Vault information"
  value = var.deploy_key_vault == 1 ? {
    vault_uri = module.key_vault[0].key_vault_uri
    vault_id  = module.key_vault[0].key_vault_id
  } : null
}

# =============================================================================
# MONITORING OUTPUTS
# =============================================================================

output "monitoring" {
  description = "Monitoring resources information"
  value = var.deploy_monitoring == 1 ? {
    log_analytics_workspace_id = module.log_analytics[0].log_analytics_workspace_id
    application_insights_app_id = module.application_insights[0].application_insights_app_id
  } : null
}

# =============================================================================
# NETWORKING SERVICES OUTPUTS
# =============================================================================

output "application_gateway" {
  description = "Application Gateway information"
  value = var.deploy_application_gateway == 1 ? {
    application_gateway_id = module.application_gateway[0].application_gateway_id
    public_ip_address     = module.application_gateway[0].public_ip_address
  } : null
}

output "cdn_profile" {
  description = "CDN Profile information"
  value = var.deploy_cdn == 1 ? {
    cdn_profile_id = module.cdn_profile[0].cdn_profile_id
    cdn_endpoint_hostname = module.cdn_profile[0].cdn_endpoint_hostname
  } : null
}

# =============================================================================
# COMMON OUTPUTS
# =============================================================================

output "location" {
  description = "Azure region used for deployment"
  value       = var.location
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "resource_prefix" {
  description = "Resource naming prefix"
  value       = "${var.project_name}-${var.environment}-${local.location_short}"
}

output "web_app_info" {
  description = "Information about Web App"
  value = var.deploy_app_services ? {
    web_app_name = module.web_app[0].app_service_name
    web_app_url  = "https://${module.web_app[0].app_service_default_hostname}"
    web_app_id   = module.web_app[0].app_service_id
  } : null
}

output "front_door_info" {
  description = "Information about Azure Front Door"
  value = var.deploy_front_door ? {
    front_door_name     = module.front_door[0].front_door_name
    front_door_endpoint = "https://${module.front_door[0].front_door_endpoint_hostname}"
    front_door_id      = module.front_door[0].front_door_id
    waf_policy_id      = module.front_door[0].waf_policy_id
  } : null
}