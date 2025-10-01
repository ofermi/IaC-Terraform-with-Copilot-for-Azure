output "bastion_id" {
  description = "Bastion host ID"
  value       = module.avm_bastion.resource_id
}

output "bastion_fqdn" {
  description = "Bastion host FQDN"
  value       = module.avm_bastion.resource.dns_name
}

output "bastion_name" {
  description = "Bastion host name"
  value       = module.avm_bastion.resource.name
}
