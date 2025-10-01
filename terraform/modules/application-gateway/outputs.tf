output "app_gateway_id" {
  description = "Application Gateway ID"
  value       = azurerm_application_gateway.app_gateway.id
}

output "app_gateway_name" {
  description = "Application Gateway name"
  value       = azurerm_application_gateway.app_gateway.name
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.app_gateway.ip_address
}
