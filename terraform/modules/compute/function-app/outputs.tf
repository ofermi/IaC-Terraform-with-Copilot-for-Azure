output "function_app_id" {
  description = "Function App ID"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_name" {
  description = "Function App name"
  value       = azurerm_linux_function_app.this.name
}

output "default_hostname" {
  description = "Default hostname"
  value       = azurerm_linux_function_app.this.default_hostname
}
