# ============================================================================
# SQL Database Module - Using Azure Verified Module (AVM)
# ============================================================================

resource "random_password" "sql_password" {
  length  = 24
  special = true
}

module "sql_server" {
  source  = "Azure/avm-res-sql-server/azurerm"
  version = "~> 0.1.5"

  name                          = var.server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  server_version                = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = random_password.sql_password.result
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
}

resource "azurerm_mssql_database" "this" {
  name      = var.database_name
  server_id = module.sql_server.resource_id
  sku_name  = var.database_sku_name
  tags      = var.tags
}
