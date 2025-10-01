output "dns_resolver_id" {
  description = "DNS resolver ID"
  value       = azurerm_private_dns_resolver.resolver.id
}

output "dns_resolver_name" {
  description = "DNS resolver name"
  value       = azurerm_private_dns_resolver.resolver.name
}

output "inbound_endpoint_id" {
  description = "Inbound endpoint ID"
  value       = azurerm_private_dns_resolver_inbound_endpoint.inbound.id
}
