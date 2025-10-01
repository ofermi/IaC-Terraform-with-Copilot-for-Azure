output "function_app_id" {
  description = "Function App ID"
  value       = azurerm_windows_function_app.function_app.id
}

output "function_app_name" {
  description = "Function App name"
  value       = azurerm_windows_function_app.function_app.name
}

output "default_hostname" {
  description = "Default hostname"
  value       = azurerm_windows_function_app.function_app.default_hostname
}
