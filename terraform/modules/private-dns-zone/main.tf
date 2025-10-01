# ==============================================================================
# Private DNS Zone Module
# ==============================================================================

resource "azurerm_private_dns_zone" "dns_zone" {
  for_each = toset(var.dns_zones)

  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each = var.vnet_links

  name                  = "link-${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone[keys(azurerm_private_dns_zone.dns_zone)[0]].name
  virtual_network_id    = each.value.vnet_id
  tags                  = var.tags

  depends_on = [azurerm_private_dns_zone.dns_zone]
}
