# Container Instances Module Outputs

output "container_group_id" {
  description = "The ID of the Container Group"
  value       = azurerm_container_group.main.id
}

output "container_group_name" {
  description = "The name of the Container Group"
  value       = azurerm_container_group.main.name
}

output "fqdn" {
  description = "The fully qualified domain name of the Container Group"
  value       = azurerm_container_group.main.fqdn
}

output "ip_address" {
  description = "The IP address of the Container Group"
  value       = azurerm_container_group.main.ip_address
}