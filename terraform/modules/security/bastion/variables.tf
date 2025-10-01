variable "name" {
  description = "Name of the Azure Bastion"
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
  description = "SKU for Azure Bastion"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Azure Bastion"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
