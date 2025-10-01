output "storage_account_id" {
  description = "Storage account ID"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Storage account name"
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "container_name" {
  description = "Container name"
  value       = azurerm_storage_container.container.name
}
