# Azure SQL Database Module
# Uses Azure Verified Module for SQL Database

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# SQL Server using AVM
module "sql_server" {
  source  = "Azure/avm-res-sql-server/azurerm"
  version = "~> 0.1.0"

  enable_telemetry                 = var.enable_telemetry
  location                        = var.location
  name                           = var.sql_server_name
  resource_group_name            = var.resource_group_name
  administrator_login            = var.administrator_login
  administrator_login_password   = var.administrator_login_password
  server_version                 = var.server_version

  # Azure AD configuration
  azuread_administrator = var.azuread_administrator

  # Firewall rules
  firewall_rules = var.firewall_rules

  tags = var.tags
}

# SQL Database using AVM
module "sql_database" {
  source  = "Azure/avm-res-sql-database/azurerm"
  version = "~> 0.1.0"

  enable_telemetry    = var.enable_telemetry
  location           = var.location
  name              = var.database_name
  resource_group_name = var.resource_group_name
  server_id         = module.sql_server.resource_id
  
  # Database configuration
  collation                        = var.database_collation
  license_type                    = var.license_type
  max_size_gb                     = var.max_size_gb
  read_scale                      = var.read_scale
  sku_name                        = var.database_sku
  zone_redundant                  = var.zone_redundant
  auto_pause_delay_in_minutes     = var.auto_pause_delay_in_minutes
  min_capacity                    = var.min_capacity

  # Backup configuration
  short_term_retention_policy = {
    retention_days = var.backup_retention_days
  }

  # Long-term retention
  long_term_retention_policy = var.enable_long_term_retention ? {
    weekly_retention  = var.weekly_retention
    monthly_retention = var.monthly_retention
    yearly_retention  = var.yearly_retention
    week_of_year     = var.week_of_year
  } : null

  tags = var.tags

  depends_on = [module.sql_server]
}