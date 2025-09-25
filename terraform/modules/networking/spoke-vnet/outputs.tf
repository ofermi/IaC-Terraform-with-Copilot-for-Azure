output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.spoke_vnet.resource_id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.spoke_vnet.name
}

output "subnets" {
  description = "The subnets of the virtual network"
  value       = module.spoke_vnet.subnets
}