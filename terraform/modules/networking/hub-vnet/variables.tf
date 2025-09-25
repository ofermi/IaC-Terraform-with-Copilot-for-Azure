variable "enable_telemetry" {
  description = "Enable telemetry for the module"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure location for the virtual network"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "gateway_subnet_prefix" {
  description = "Address prefix for gateway subnet"
  type        = string
}

variable "firewall_subnet_prefix" {
  description = "Address prefix for firewall subnet"
  type        = string
}

variable "shared_services_subnet_prefix" {
  description = "Address prefix for shared services subnet"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location_short" {
  description = "Short name for location"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}