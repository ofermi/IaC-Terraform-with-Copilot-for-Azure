# ==============================================================================
# Virtual Network Module
# Using Azure Verified Modules (AVM)
# ==============================================================================

module "avm_virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.7.1"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  subnets = {
    for key, subnet in var.subnets : key => {
      name             = subnet.name
      address_prefixes = subnet.address_prefixes
    }
  }

  tags = var.tags
}
