# Network Security Group Module
# Uses Azure Verified Module for NSG

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Network Security Group using AVM
module "network_security_group" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "~> 0.1.0"

  enable_telemetry    = var.enable_telemetry
  location           = var.location
  name               = var.nsg_name
  resource_group_name = var.resource_group_name

  # Security rules
  nsgrules = var.security_rules

  tags = var.tags
}