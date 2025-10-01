output "dns_zone_ids" {
  description = "Map of DNS zone IDs"
  value       = { for k, v in azurerm_private_dns_zone.dns_zone : k => v.id }
}

output "dns_zone_names" {
  description = "Map of DNS zone names"
  value       = { for k, v in azurerm_private_dns_zone.dns_zone : k => v.name }
}
