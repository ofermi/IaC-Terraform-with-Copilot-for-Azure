# ============================================================================
# Virtual Network Module - Using Azure Verified Module (AVM)
# ============================================================================

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

module "virtual_network" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "~> 0.7"

  name          = var.name
  parent_id     = data.azurerm_resource_group.this.id
  location      = var.location
  address_space = var.address_space
  
  subnets = {
    for key, subnet in var.subnets : key => {
      address_prefixes = subnet.address_prefixes
    }
  }

  tags = var.tags
}
