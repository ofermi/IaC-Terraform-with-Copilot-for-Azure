output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.hub_vnet.resource_id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = module.hub_vnet.name
}

output "subnets" {
  description = "The subnets of the virtual network"
  value       = module.hub_vnet.subnets
}

output "gateway_subnet_id" {
  description = "The ID of the gateway subnet"
  value       = module.hub_vnet.subnets["gateway_subnet"].resource_id
}

output "firewall_subnet_id" {
  description = "The ID of the firewall subnet"
  value       = module.hub_vnet.subnets["firewall_subnet"].resource_id
}

output "shared_services_subnet_id" {
  description = "The ID of the shared services subnet"
  value       = module.hub_vnet.subnets["shared_services_subnet"].resource_id
}