# SQL Database Module Outputs

output "sql_server_id" {
  description = "The ID of the SQL Server"
  value       = module.sql_server.resource_id
}

output "sql_server_name" {
  description = "The name of the SQL Server"
  value       = module.sql_server.resource.name
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the SQL Server"
  value       = module.sql_server.resource.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "The ID of the SQL Database"
  value       = module.sql_database.resource_id
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = module.sql_database.resource.name
}

output "connection_string" {
  description = "Connection string for the database (without password)"
  value       = "Server=${module.sql_server.resource.fully_qualified_domain_name};Database=${module.sql_database.resource.name};User ID=${var.administrator_login};"
  sensitive   = false
}