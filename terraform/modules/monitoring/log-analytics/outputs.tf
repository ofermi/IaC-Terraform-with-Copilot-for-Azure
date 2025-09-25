# Log Analytics Workspace Module Outputs

output "workspace_id" {
  description = "The ID of the Log Analytics workspace"
  value       = module.log_analytics.resource_id
}

output "workspace_name" {
  description = "The name of the Log Analytics workspace"
  value       = module.log_analytics.resource.name
}

output "workspace_customer_id" {
  description = "The customer ID (workspace ID) of the Log Analytics workspace"
  value       = module.log_analytics.resource.workspace_id
}

output "primary_shared_key" {
  description = "The primary shared key of the Log Analytics workspace"
  value       = module.log_analytics.resource.primary_shared_key
  sensitive   = true
}