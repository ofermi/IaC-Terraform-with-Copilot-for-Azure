# Log Analytics Workspace Module Variables

variable "enable_telemetry" {
  description = "Enable telemetry for Azure Verified Module"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region where the Log Analytics workspace will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "workspace_name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}