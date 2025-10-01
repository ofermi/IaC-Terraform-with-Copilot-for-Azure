# ==============================================================================
# Resource Group Module
# Using native Azure resources (for azurerm 4.x compatibility)
# ==============================================================================

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
