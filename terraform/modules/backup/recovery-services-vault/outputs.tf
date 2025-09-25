# Azure Backup Module Outputs

output "recovery_vault_id" {
  description = "The ID of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.main.id
}

output "recovery_vault_name" {
  description = "The name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.main.name
}

output "vm_backup_policy_id" {
  description = "The ID of the VM backup policy"
  value       = var.enable_vm_backup ? azurerm_backup_policy_vm.main[0].id : null
}

output "file_share_backup_policy_id" {
  description = "The ID of the file share backup policy"
  value       = var.enable_file_share_backup ? azurerm_backup_policy_file_share.main[0].id : null
}