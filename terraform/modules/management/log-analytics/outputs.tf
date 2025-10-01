output "workspace_id" {
  description = "Log Analytics Workspace ID"
  value       = module.log_analytics.resource_id
}

output "workspace_name" {
  description = "Log Analytics Workspace name"
  value       = module.log_analytics.resource.name
}

output "primary_shared_key" {
  description = "Primary shared key"
  value       = module.log_analytics.resource.primary_shared_key
  sensitive   = true
}
