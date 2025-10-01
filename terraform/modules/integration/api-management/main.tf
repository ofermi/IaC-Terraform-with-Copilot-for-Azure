# ============================================================================
# API Management Module - Using Azure Verified Module (AVM)
# ============================================================================

module "api_management" {
  source  = "Azure/avm-res-apimanagement-service/azurerm"
  version = "~> 0.0.5"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name
  
  virtual_network_type      = "Internal"
  virtual_network_subnet_id = var.subnet_id

  tags = var.tags
}
