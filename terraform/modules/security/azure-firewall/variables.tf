variable "name" {
  description = "Name of the Azure Firewall"
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

variable "sku_name" {
  description = "SKU name for Azure Firewall"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for Azure Firewall"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for Azure Firewall"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
