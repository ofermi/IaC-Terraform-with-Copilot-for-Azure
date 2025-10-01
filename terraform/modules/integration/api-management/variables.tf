variable "name" {
  description = "Name of the API Management"
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

variable "publisher_name" {
  description = "Publisher name"
  type        = string
}

variable "publisher_email" {
  description = "Publisher email"
  type        = string
}

variable "sku_name" {
  description = "SKU name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for APIM"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
