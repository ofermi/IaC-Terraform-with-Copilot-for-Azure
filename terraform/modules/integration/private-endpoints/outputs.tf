output "private_endpoint_id" {
  description = "Private endpoint ID"
  value       = azurerm_private_endpoint.this.id
}

output "private_endpoint_name" {
  description = "Private endpoint name"
  value       = azurerm_private_endpoint.this.name
}

output "private_ip_address" {
  description = "Private IP address"
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}
