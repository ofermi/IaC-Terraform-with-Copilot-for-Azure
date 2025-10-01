# ==============================================================================
# Monitoring Module
# ==============================================================================

# This module sets up Azure Monitor diagnostics settings and alerts

resource "azurerm_monitor_diagnostic_setting" "governance" {
  name                       = "diag-governance"
  target_resource_id         = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "ServiceHealth"
  }

  enabled_log {
    category = "Alert"
  }

  enabled_log {
    category = "Recommendation"
  }

  enabled_log {
    category = "Policy"
  }

  enabled_log {
    category = "Autoscale"
  }

  enabled_log {
    category = "ResourceHealth"
  }
}

data "azurerm_client_config" "current" {}
