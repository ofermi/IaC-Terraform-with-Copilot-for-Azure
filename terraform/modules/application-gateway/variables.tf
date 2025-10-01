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
  description = "SKU name"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier"
  type        = string
}

variable "sku_capacity" {
  description = "SKU capacity"
  type        = number
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
