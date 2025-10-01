variable "name" {
  description = "Name of the private endpoint"
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
  description = "Subnet ID"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Private connection resource ID"
  type        = string
}

variable "subresource_names" {
  description = "Subresource names"
  type        = list(string)
}

variable "private_dns_zone_ids" {
  description = "Private DNS zone IDs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
