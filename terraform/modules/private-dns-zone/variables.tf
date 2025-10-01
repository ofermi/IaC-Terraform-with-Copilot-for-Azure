variable "dns_zones" {
  description = "List of DNS zone names"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_links" {
  description = "Map of VNet links"
  type = map(object({
    vnet_id   = string
    vnet_name = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
