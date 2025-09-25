# Network Security Group Module Variables

variable "enable_telemetry" {
  description = "Enable telemetry for Azure Verified Module"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region where the NSG will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  type        = string
}

variable "security_rules" {
  description = "Map of security rules for the NSG"
  type = map(object({
    access                     = string
    direction                 = string
    priority                  = number
    protocol                  = string
    source_port_range         = optional(string)
    source_port_ranges        = optional(list(string))
    destination_port_range    = optional(string)
    destination_port_ranges   = optional(list(string))
    source_address_prefix     = optional(string)
    source_address_prefixes   = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
    description               = optional(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}