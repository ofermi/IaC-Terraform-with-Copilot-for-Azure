# ============================================================================
# Resource Group Outputs
# ============================================================================

output "resource_groups" {
  description = "Map of all resource groups"
  value = {
    hub        = module.resource_groups["hub"]
    apim       = module.resource_groups["apim"]
    mgmt       = module.resource_groups["mgmt"]
    spoke01    = module.resource_groups["spoke01"]
    spoke02    = module.resource_groups["spoke02"]
    iac        = module.resource_groups["iac"]
    dns        = module.resource_groups["dns"]
    governance = module.resource_groups["governance"]
  }
}

# ============================================================================
# Virtual Network Outputs
# ============================================================================

output "vnets" {
  description = "Map of all virtual networks"
  value = {
    hub     = module.virtual_networks["hub"]
    apim    = module.virtual_networks["apim"]
    mgmt    = module.virtual_networks["mgmt"]
    spoke01 = module.virtual_networks["spoke01"]
    spoke02 = module.virtual_networks["spoke02"]
    iac     = module.virtual_networks["iac"]
    dns     = module.virtual_networks["dns"]
  }
  sensitive = true
}

# ============================================================================
# Azure Firewall Outputs
# ============================================================================

output "azure_firewall" {
  description = "Azure Firewall details"
  value       = local.create_azure_firewall ? module.azure_firewall[0] : null
}

# ============================================================================
# Application Gateway Outputs
# ============================================================================

output "application_gateway" {
  description = "Application Gateway details"
  value       = local.create_application_gateway ? module.application_gateway[0] : null
}

# ============================================================================
# API Management Outputs
# ============================================================================

output "api_management" {
  description = "API Management details"
  value       = local.create_api_management ? module.api_management[0] : null
  sensitive   = true
}

# ============================================================================
# Log Analytics Workspace Outputs
# ============================================================================

output "log_analytics_workspace" {
  description = "Log Analytics Workspace details"
  value       = local.create_log_analytics ? module.log_analytics[0] : null
  sensitive   = true
}

# ============================================================================
# SQL Database Outputs
# ============================================================================

output "sql_server" {
  description = "SQL Server details"
  value       = local.create_sql_database ? module.sql_database[0] : null
  sensitive   = true
}

# ============================================================================
# Storage Account Outputs
# ============================================================================

output "storage_accounts" {
  description = "Storage accounts details"
  value       = module.storage_accounts
  sensitive   = true
}

# ============================================================================
# Private DNS Zones Outputs
# ============================================================================

output "private_dns_zones" {
  description = "Private DNS Zones details"
  value       = local.create_private_dns_zones ? module.private_dns_zones : null
}
