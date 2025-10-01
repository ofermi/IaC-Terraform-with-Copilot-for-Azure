# ==============================================================================
# Log Analytics Workspace Module
# Using Azure Verified Modules (AVM)
# ==============================================================================

module "avm_log_analytics" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.4.1"

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  log_analytics_workspace_sku   = var.sku
  log_analytics_workspace_retention_in_days = var.retention_in_days

  tags = var.tags
}
