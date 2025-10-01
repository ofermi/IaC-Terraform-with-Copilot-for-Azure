# ============================================================================
# Project Configuration Variables
# ============================================================================

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "location_short" {
  description = "Short name for Azure region"
  type        = string
}

# ============================================================================
# Tags Variables
# ============================================================================

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

# ============================================================================
# Network Address Spaces Variables
# ============================================================================

# Hub VNet
variable "hub_vnet_address_space" {
  description = "Address space for Hub VNet"
  type        = list(string)
}

variable "hub_subnets" {
  description = "Subnets configuration for Hub VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# APIM VNet
variable "apim_vnet_address_space" {
  description = "Address space for APIM VNet"
  type        = list(string)
}

variable "apim_subnets" {
  description = "Subnets configuration for APIM VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# Management VNet
variable "mgmt_vnet_address_space" {
  description = "Address space for Management VNet"
  type        = list(string)
}

variable "mgmt_subnets" {
  description = "Subnets configuration for Management VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# Spoke 01 VNet
variable "spoke01_vnet_address_space" {
  description = "Address space for Spoke 01 VNet"
  type        = list(string)
}

variable "spoke01_subnets" {
  description = "Subnets configuration for Spoke 01 VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# Spoke 02 VNet
variable "spoke02_vnet_address_space" {
  description = "Address space for Spoke 02 VNet"
  type        = list(string)
}

variable "spoke02_subnets" {
  description = "Subnets configuration for Spoke 02 VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# IaC VNet
variable "iac_vnet_address_space" {
  description = "Address space for IaC VNet"
  type        = list(string)
}

variable "iac_subnets" {
  description = "Subnets configuration for IaC VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

# DNS VNet
variable "dns_vnet_address_space" {
  description = "Address space for DNS VNet"
  type        = list(string)
}

variable "dns_subnets" {
  description = "Subnets configuration for DNS VNet"
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
