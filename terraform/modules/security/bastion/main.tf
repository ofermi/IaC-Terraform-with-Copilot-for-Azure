# ============================================================================
# Azure Bastion Module
# ============================================================================

resource "azurerm_public_ip" "bastion" {
  name                = "pip-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  tags                = var.tags

  ip_configuration {
    name                 = "ipconfig1"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}
