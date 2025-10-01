# ============================================================================
# Monitoring Module
# ============================================================================

# Azure Monitor Action Group
resource "azurerm_monitor_action_group" "this" {
  name                = "ag-${var.resource_group_name}"
  resource_group_name = var.resource_group_name
  short_name          = "monitoring"
  tags                = var.tags
}

# Diagnostic Settings can be added here for specific resources
# This is a placeholder for centralized monitoring configuration
