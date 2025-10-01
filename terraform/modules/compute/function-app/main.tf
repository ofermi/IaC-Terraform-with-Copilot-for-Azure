# ============================================================================
# Function App Module
# ============================================================================

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
  tags                = var.tags
}

resource "azurerm_linux_function_app" "this" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_key
  tags                       = var.tags

  site_config {
    application_stack {
      dotnet_version = var.runtime == "dotnet" ? "8.0" : null
      python_version = var.runtime == "python" ? "3.11" : null
      node_version   = var.runtime == "node" ? "20" : null
    }
  }

  virtual_network_subnet_id = var.subnet_id
}
