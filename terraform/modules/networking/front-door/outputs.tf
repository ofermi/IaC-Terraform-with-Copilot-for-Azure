output "front_door_id" {
  description = "ID of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.front_door.id
}

output "front_door_name" {
  description = "Name of the Front Door profile"
  value       = azurerm_cdn_frontdoor_profile.front_door.name
}

output "front_door_endpoint_id" {
  description = "ID of the Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.front_door_endpoint.id
}

output "front_door_endpoint_hostname" {
  description = "Hostname of the Front Door endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.front_door_endpoint.host_name
}

output "front_door_origin_group_id" {
  description = "ID of the Front Door origin group"
  value       = azurerm_cdn_frontdoor_origin_group.app_origin_group.id
}

output "waf_policy_id" {
  description = "ID of the WAF policy"
  value       = var.enable_waf ? azurerm_cdn_frontdoor_firewall_policy.waf_policy[0].id : null
}