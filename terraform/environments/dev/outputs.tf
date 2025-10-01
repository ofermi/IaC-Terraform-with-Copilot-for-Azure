# ==============================================================================
# Resource Group Outputs
# ==============================================================================

output "resource_group_names" {
  description = "Map of all resource group names"
  value = {
    hub        = var.create_hub_resources ? module.rg_hub[0].name : null
    apm        = var.create_apm_resources ? module.rg_apm[0].name : null
    management = var.create_management_resources ? module.rg_management[0].name : null
    spoke01    = var.create_spoke01_resources ? module.rg_spoke01[0].name : null
    spoke02    = var.create_spoke02_resources ? module.rg_spoke02[0].name : null
    iac        = var.create_iac_resources ? module.rg_iac[0].name : null
    dns        = var.create_dns_resources ? module.rg_dns[0].name : null
    governance = var.create_monitoring ? module.rg_governance[0].name : null
  }
}

# ==============================================================================
# VNet Outputs
# ==============================================================================

output "vnet_ids" {
  description = "Map of all VNet IDs"
  value = {
    hub        = var.create_hub_resources ? module.vnet_hub[0].vnet_id : null
    apm        = var.create_apm_resources ? module.vnet_apm[0].vnet_id : null
    management = var.create_management_resources ? module.vnet_management[0].vnet_id : null
    spoke01    = var.create_spoke01_resources ? module.vnet_spoke01[0].vnet_id : null
    spoke02    = var.create_spoke02_resources ? module.vnet_spoke02[0].vnet_id : null
    iac        = var.create_iac_resources ? module.vnet_iac[0].vnet_id : null
  }
}

output "vnet_names" {
  description = "Map of all VNet names"
  value = {
    hub        = var.create_hub_resources ? module.vnet_hub[0].vnet_name : null
    apm        = var.create_apm_resources ? module.vnet_apm[0].vnet_name : null
    management = var.create_management_resources ? module.vnet_management[0].vnet_name : null
    spoke01    = var.create_spoke01_resources ? module.vnet_spoke01[0].vnet_name : null
    spoke02    = var.create_spoke02_resources ? module.vnet_spoke02[0].vnet_name : null
    iac        = var.create_iac_resources ? module.vnet_iac[0].vnet_name : null
  }
}

# ==============================================================================
# Bastion Outputs
# ==============================================================================

output "bastion_id" {
  description = "Azure Bastion resource ID"
  value       = var.create_bastion ? module.bastion[0].bastion_id : null
}

output "bastion_fqdn" {
  description = "Azure Bastion FQDN"
  value       = var.create_bastion ? module.bastion[0].bastion_fqdn : null
}

# ==============================================================================
# API Management Outputs
# ==============================================================================

output "apim_id" {
  description = "API Management resource ID"
  value       = var.create_api_management ? module.api_management[0].apim_id : null
}

output "apim_gateway_url" {
  description = "API Management gateway URL"
  value       = var.create_api_management ? module.api_management[0].apim_gateway_url : null
}

# ==============================================================================
# Application Gateway Outputs
# ==============================================================================

output "app_gateway_id" {
  description = "Application Gateway resource ID"
  value       = var.create_application_gateway ? module.application_gateway[0].app_gateway_id : null
}

output "app_gateway_public_ip" {
  description = "Application Gateway public IP address"
  value       = var.create_application_gateway ? module.application_gateway[0].public_ip_address : null
}

# ==============================================================================
# Log Analytics Outputs
# ==============================================================================

output "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = var.create_monitoring ? module.log_analytics[0].workspace_id : null
}

output "log_analytics_workspace_name" {
  description = "Log Analytics Workspace name"
  value       = var.create_monitoring ? module.log_analytics[0].workspace_name : null
}

# ==============================================================================
# SQL Database Outputs
# ==============================================================================

output "sql_server_fqdn" {
  description = "SQL Server FQDN"
  value       = var.create_spoke02_resources ? module.sql_database[0].sql_server_fqdn : null
}

output "sql_database_name" {
  description = "SQL Database name"
  value       = var.create_spoke02_resources ? module.sql_database[0].database_name : null
}

# ==============================================================================
# Function App Outputs
# ==============================================================================

output "function_app_name" {
  description = "Function App name"
  value       = var.create_spoke02_resources ? module.function_app[0].function_app_name : null
}

output "function_app_default_hostname" {
  description = "Function App default hostname"
  value       = var.create_spoke02_resources ? module.function_app[0].default_hostname : null
}

# ==============================================================================
# Storage Account Outputs
# ==============================================================================

output "tfstate_storage_account_name" {
  description = "Terraform state storage account name"
  value       = var.create_iac_resources ? module.storage_tfstate[0].storage_account_name : null
}
