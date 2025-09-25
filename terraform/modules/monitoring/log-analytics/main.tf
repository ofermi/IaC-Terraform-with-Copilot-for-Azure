# Log Analytics Workspace Module
# Uses Azure Verified Module for Log Analytics

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Log Analytics Workspace using AVM
module "log_analytics" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "~> 0.1.0"

  enable_telemetry    = var.enable_telemetry
  location           = var.location
  name               = var.workspace_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}