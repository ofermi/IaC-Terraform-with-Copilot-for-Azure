variable "name" {
  description = "Name of the Application Gateway"
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
  description = "SKU name for Application Gateway"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for Application Gateway"
  type        = string
}

variable "sku_capacity" {
  description = "SKU capacity for Application Gateway"
  type        = number
}

variable "subnet_id" {
  description = "Subnet ID for Application Gateway"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
