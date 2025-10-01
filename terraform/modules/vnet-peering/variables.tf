variable "peering_name" {
  description = "Name of the peering"
  type        = string
}

variable "source_vnet_name" {
  description = "Source virtual network name"
  type        = string
}

variable "source_resource_group_name" {
  description = "Source resource group name"
  type        = string
}

variable "destination_vnet_id" {
  description = "Destination virtual network ID"
  type        = string
}

variable "allow_virtual_network_access" {
  description = "Allow virtual network access"
  type        = bool
  default     = true
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic"
  type        = bool
  default     = false
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit"
  type        = bool
  default     = false
}

variable "use_remote_gateways" {
  description = "Use remote gateways"
  type        = bool
  default     = false
}
