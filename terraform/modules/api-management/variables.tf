variable "name" {
  description = "Name of the API Management service"
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
  description = "SKU name for API Management"
  type        = string
}

variable "publisher_name" {
  description = "Publisher name"
  type        = string
}

variable "publisher_email" {
  description = "Publisher email"
  type        = string
}

variable "virtual_network_type" {
  description = "Virtual network type (None, External, Internal)"
  type        = string
  default     = "None"
}

variable "subnet_id" {
  description = "Subnet ID for API Management"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the API Management service"
  type        = map(string)
  default     = {}
}
