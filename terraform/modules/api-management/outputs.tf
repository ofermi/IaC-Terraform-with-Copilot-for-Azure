output "apim_id" {
  description = "API Management ID"
  value       = azurerm_api_management.apim.id
}

output "apim_gateway_url" {
  description = "API Management gateway URL"
  value       = azurerm_api_management.apim.gateway_url
}

output "apim_name" {
  description = "API Management name"
  value       = azurerm_api_management.apim.name
}
