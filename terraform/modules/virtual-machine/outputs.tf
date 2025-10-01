output "vm_id" {
  description = "VM ID"
  value       = module.avm_virtual_machine.resource_id
}

output "vm_name" {
  description = "VM name"
  value       = module.avm_virtual_machine.name
}

output "private_ip_address" {
  description = "Private IP address"
  value       = azurerm_network_interface.nic.private_ip_address
}
