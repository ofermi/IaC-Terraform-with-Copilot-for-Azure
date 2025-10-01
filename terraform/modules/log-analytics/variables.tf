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
  description = "SKU"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Retention in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
