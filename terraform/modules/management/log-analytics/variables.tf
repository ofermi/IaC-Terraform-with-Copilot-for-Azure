variable "name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sku" {
  description = "SKU for Log Analytics Workspace"
  type        = string
}

variable "retention_in_days" {
  description = "Retention in days"
  type        = number
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
