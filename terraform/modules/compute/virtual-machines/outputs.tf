output "vm_id" {
  description = "ID of the virtual machine"
  value       = var.os_type == "Linux" ? try(azurerm_linux_virtual_machine.vm[0].id, null) : try(azurerm_windows_virtual_machine.vm[0].id, null)
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = var.vm_name
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_nic_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.vm_nic.id
}

output "ssh_private_key" {
  description = "Generated SSH private key for Linux VMs"
  value       = var.os_type == "Linux" && var.ssh_public_key == null ? tls_private_key.vm_ssh[0].private_key_pem : null
  sensitive   = true
}

output "admin_password" {
  description = "Generated admin password for Windows VMs"
  value       = var.os_type == "Windows" && var.admin_password == null ? random_password.vm_password[0].result : null
  sensitive   = true
}