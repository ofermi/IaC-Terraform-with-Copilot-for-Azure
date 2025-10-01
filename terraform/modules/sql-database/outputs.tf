output "sql_server_id" {
  description = "SQL Server ID"
  value       = azurerm_mssql_server.server.id
}

output "sql_server_fqdn" {
  description = "SQL Server FQDN"
  value       = azurerm_mssql_server.server.fully_qualified_domain_name
}

output "database_id" {
  description = "Database ID"
  value       = azurerm_mssql_database.database.id
}

output "database_name" {
  description = "Database name"
  value       = azurerm_mssql_database.database.name
}
