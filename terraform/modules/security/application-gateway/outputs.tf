output "appgw_id" {
  description = "Application Gateway ID"
  value       = azurerm_application_gateway.this.id
}

output "appgw_name" {
  description = "Application Gateway name"
  value       = azurerm_application_gateway.this.name
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.appgw.ip_address
}
