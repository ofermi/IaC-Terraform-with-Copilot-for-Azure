output "storage_account_id" {
  description = "Storage account ID"
  value       = module.storage_account.resource_id
}

output "storage_account_name" {
  description = "Storage account name"
  value       = module.storage_account.name
}

output "primary_access_key" {
  description = "Primary access key"
  value       = module.storage_account.resource.primary_access_key
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage_account.resource.primary_blob_endpoint
}
