# ============================================================================
# Application Gateway Module
# ============================================================================

resource "azurerm_public_ip" "appgw" {
  name                = "pip-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_application_gateway" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = "ipconfig1"
    subnet_id = var.subnet_id
  }

  frontend_port {
    name = "frontendport-80"
    port = 80
  }

  frontend_port {
    name = "frontendport-443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.appgw.id
  }

  backend_address_pool {
    name = "defaultbackendpool"
  }

  backend_http_settings {
    name                  = "defaulthttpsettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  http_listener {
    name                           = "defaultlistener"
    frontend_ip_configuration_name = "frontendip"
    frontend_port_name             = "frontendport-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "defaultrule"
    rule_type                  = "Basic"
    http_listener_name         = "defaultlistener"
    backend_address_pool_name  = "defaultbackendpool"
    backend_http_settings_name = "defaulthttpsettings"
    priority                   = 100
  }
}
