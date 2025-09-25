# Spoke Virtual Network Module
# Uses Azure Verified Module for Virtual Network

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Spoke VNet using AVM
module "spoke_vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.1.0"

  enable_telemetry             = var.enable_telemetry
  location                     = var.location
  name                         = var.vnet_name
  resource_group_name          = var.resource_group_name
  virtual_network_address_space = var.address_space

  subnets = var.subnets

  tags = var.tags
}