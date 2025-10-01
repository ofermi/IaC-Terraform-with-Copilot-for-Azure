# ============================================================================
# Private DNS Zone Module
# ============================================================================

resource "azurerm_private_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.vnet_links

  name                  = "link-${each.key}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.vnet_id
  registration_enabled  = try(each.value.registration_enabled, false)
  tags                  = var.tags
}
