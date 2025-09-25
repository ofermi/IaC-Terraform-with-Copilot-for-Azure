# Network Security Group Module Outputs

output "nsg_id" {
  description = "The ID of the Network Security Group"
  value       = module.network_security_group.resource_id
}

output "nsg_name" {
  description = "The name of the Network Security Group"
  value       = module.network_security_group.resource.name
}

output "security_rules" {
  description = "The security rules of the Network Security Group"
  value       = module.network_security_group.resource.security_rule
}