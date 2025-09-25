variable "hub_vnet_name" {
  description = "Name of the hub virtual network"
  type        = string
}

variable "spoke_vnet_name" {
  description = "Name of the spoke virtual network"
  type        = string
}

variable "hub_resource_group_name" {
  description = "Resource group name for hub VNet"
  type        = string
}

variable "spoke_resource_group_name" {
  description = "Resource group name for spoke VNet"
  type        = string
}

variable "hub_vnet_id" {
  description = "ID of the hub virtual network"
  type        = string
}

variable "spoke_vnet_id" {
  description = "ID of the spoke virtual network"
  type        = string
}

variable "allow_forwarded_traffic" {
  description = "Allow forwarded traffic through the peering"
  type        = bool
  default     = true
}

variable "allow_gateway_transit" {
  description = "Allow gateway transit on hub VNet"
  type        = bool
  default     = true
}

variable "use_remote_gateways" {
  description = "Use remote gateways on spoke VNet"
  type        = bool
  default     = false
}