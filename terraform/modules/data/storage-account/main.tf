# ============================================================================
# Storage Account Module - Using Azure Verified Module (AVM)
# ============================================================================

module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "~> 0.4"

  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  tags                     = var.tags
}
