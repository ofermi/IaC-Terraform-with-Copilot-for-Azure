output "apim_id" {
  description = "API Management ID"
  value       = module.api_management.resource_id
}

output "apim_name" {
  description = "API Management name"
  value       = module.api_management.name
}

output "gateway_url" {
  description = "Gateway URL"
  value       = module.api_management.resource.gateway_url
}
