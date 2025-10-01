output "sql_server_id" {
  description = "SQL Server ID"
  value       = module.sql_server.resource_id
}

output "sql_server_name" {
  description = "SQL Server name"
  value       = module.sql_server.resource_name
}

output "sql_database_id" {
  description = "SQL Database ID"
  value       = azurerm_mssql_database.this.id
}

output "sql_database_name" {
  description = "SQL Database name"
  value       = azurerm_mssql_database.this.name
}

output "administrator_password" {
  description = "Administrator password"
  value       = random_password.sql_password.result
  sensitive   = true
}
