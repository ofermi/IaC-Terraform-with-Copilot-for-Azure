output "app_service_id" {
  description = "ID of the App Service"
  value       = module.app_service.resource_id
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = module.app_service.name
}

output "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  value       = module.app_service.default_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP addresses of the App Service"
  value       = module.app_service.outbound_ip_addresses
}