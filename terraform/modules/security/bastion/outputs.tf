output "bastion_id" {
  description = "Azure Bastion ID"
  value       = azurerm_bastion_host.this.id
}

output "bastion_name" {
  description = "Azure Bastion name"
  value       = azurerm_bastion_host.this.name
}

output "public_ip_address" {
  description = "Public IP address"
  value       = azurerm_public_ip.bastion.ip_address
}
