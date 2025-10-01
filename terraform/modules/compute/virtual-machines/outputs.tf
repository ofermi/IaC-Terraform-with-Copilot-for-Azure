output "vm_id" {
  description = "Virtual machine ID"
  value       = var.os_type == "Windows" ? azurerm_windows_virtual_machine.windows[0].id : azurerm_linux_virtual_machine.linux[0].id
}

output "vm_name" {
  description = "Virtual machine name"
  value       = var.name
}

output "private_ip_address" {
  description = "Private IP address"
  value       = azurerm_network_interface.this.private_ip_address
}

output "admin_password" {
  description = "Admin password"
  value       = random_password.vm_password.result
  sensitive   = true
}
