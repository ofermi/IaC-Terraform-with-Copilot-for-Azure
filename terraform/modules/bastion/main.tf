# ==============================================================================
# Azure Bastion Module
# Using Azure Verified Modules (AVM)
# ==============================================================================

resource "azurerm_public_ip" "bastion" {
  name                = "pip-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "avm_bastion" {
  source  = "Azure/avm-res-network-bastionhost/azurerm"
  version = "0.3.1"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  ip_configuration = {
    name                 = "ipconfig1"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }

  tags = var.tags
}
