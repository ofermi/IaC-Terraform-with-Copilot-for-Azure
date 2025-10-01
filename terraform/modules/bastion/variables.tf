variable "name" {
  description = "Name of the Bastion host"
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

variable "subnet_id" {
  description = "Bastion subnet ID"
  type        = string
}

variable "sku" {
  description = "Bastion SKU"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags for the Bastion host"
  type        = map(string)
  default     = {}
}
