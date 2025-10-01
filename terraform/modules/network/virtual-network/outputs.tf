output "vnet_id" {
  description = "Virtual network ID"
  value       = module.virtual_network.resource_id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = module.virtual_network.name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for key, subnet in module.virtual_network.subnets : key => subnet.resource_id }
}

output "address_space" {
  description = "Address space of the virtual network"
  value       = var.address_space
}
