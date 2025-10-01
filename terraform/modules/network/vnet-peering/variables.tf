variable "peering_name" {
  description = "Name of the VNet peering"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the source virtual network"
  type        = string
}

variable "remote_virtual_network_id" {
  description = "ID of the remote virtual network"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow virtual network access"
  type        = bool
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic"
  type        = bool
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit"
  type        = bool
}

variable "use_remote_gateways" {
  description = "Use remote gateways"
  type        = bool
}
