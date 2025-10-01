variable "name" {
  description = "Name of the DNS resolver"
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

variable "virtual_network_id" {
  description = "Virtual network ID"
  type        = string
}

variable "inbound_subnet_id" {
  description = "Inbound subnet ID"
  type        = string
}

variable "outbound_subnet_id" {
  description = "Outbound subnet ID"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
