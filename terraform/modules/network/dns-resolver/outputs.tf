output "resolver_id" {
  description = "DNS resolver ID"
  value       = azurerm_private_dns_resolver.this.id
}

output "inbound_endpoint_id" {
  description = "Inbound endpoint ID"
  value       = azurerm_private_dns_resolver_inbound_endpoint.this.id
}

output "outbound_endpoint_id" {
  description = "Outbound endpoint ID"
  value       = azurerm_private_dns_resolver_outbound_endpoint.this.id
}
