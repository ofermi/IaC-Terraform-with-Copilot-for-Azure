# ============================================================================
# Azure Firewall Module - Using Azure Verified Module (AVM)
# ============================================================================

resource "azurerm_public_ip" "firewall" {
  name                = "pip-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

module "azure_firewall" {
  source  = "Azure/avm-res-network-azurefirewall/azurerm"
  version = "~> 0.3"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  firewall_sku_name   = var.sku_name
  firewall_sku_tier   = var.sku_tier

  firewall_ip_configuration = [{
    name                 = "ipconfig1"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }]

  tags = var.tags
}
