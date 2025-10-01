output "peering_id" {
  description = "Peering ID"
  value       = azurerm_virtual_network_peering.peering.id
}

output "peering_name" {
  description = "Peering name"
  value       = azurerm_virtual_network_peering.peering.name
}
