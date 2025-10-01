# ==============================================================================
# DNS Resolver Module
# ==============================================================================

resource "azurerm_private_dns_resolver" "resolver" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.virtual_network_id
  tags                = var.tags
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {
  name                    = "${var.name}-inbound"
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  location                = var.location

  ip_configurations {
    subnet_id = var.inbound_subnet_id
  }

  tags = var.tags
}
