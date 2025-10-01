# ==============================================================================
# SQL Database Module
# Using native Azure resources (for azurerm 4.x compatibility)
# ==============================================================================

resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "database" {
  name      = var.database_name
  server_id = azurerm_mssql_server.server.id
  sku_name  = var.sku_name

  tags = var.tags
}
