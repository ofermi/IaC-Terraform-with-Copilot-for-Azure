output "workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = module.avm_log_analytics.resource_id
}

output "workspace_name" {
  description = "Log Analytics Workspace name"
  value       = module.avm_log_analytics.resource.name
}

output "workspace_key" {
  description = "Log Analytics Workspace key"
  value       = module.avm_log_analytics.resource.primary_shared_key
  sensitive   = true
}
