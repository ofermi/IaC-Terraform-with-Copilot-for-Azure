variable "name" {
  description = "Name of the Function App"
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

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_account_key" {
  description = "Storage account access key"
  type        = string
  sensitive   = true
}

variable "runtime" {
  description = "Runtime for Function App"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for VNet integration"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
