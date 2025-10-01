variable "name" {
  description = "Name of the virtual network"
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

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnets"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags for the virtual network"
  type        = map(string)
  default     = {}
}
