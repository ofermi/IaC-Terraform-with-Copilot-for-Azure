output "action_group_id" {
  description = "Action group ID"
  value       = azurerm_monitor_action_group.this.id
}

output "action_group_name" {
  description = "Action group name"
  value       = azurerm_monitor_action_group.this.name
}
