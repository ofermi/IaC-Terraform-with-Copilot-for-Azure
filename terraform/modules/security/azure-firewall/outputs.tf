output "firewall_id" {
  description = "Azure Firewall ID"
  value       = module.azure_firewall.resource_id
}

output "firewall_name" {
  description = "Azure Firewall name"
  value       = module.azure_firewall.resource.name
}

output "firewall_private_ip" {
  description = "Azure Firewall private IP"
  value       = module.azure_firewall.resource.ip_configuration[0].private_ip_address
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.firewall.ip_address
}
