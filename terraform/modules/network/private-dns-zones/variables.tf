variable "name" {
  description = "Name of the private DNS zone"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_links" {
  description = "VNet links for the DNS zone"
  type = map(object({
    vnet_id               = string
    registration_enabled  = optional(bool, false)
  }))
  default = {}
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
