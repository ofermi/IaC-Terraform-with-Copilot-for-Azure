output "vnet_id" {
  description = "Virtual network ID"
  value       = module.avm_virtual_network.resource_id
}

output "vnet_name" {
  description = "Virtual network name"
  value       = module.avm_virtual_network.name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = { for k, v in module.avm_virtual_network.subnets : k => v.resource_id }
}

output "subnet_names" {
  description = "Map of subnet names"
  value       = { for k, v in module.avm_virtual_network.subnets : k => v.name }
}
