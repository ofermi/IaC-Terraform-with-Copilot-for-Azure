# Storage Account Module
# Uses Azure Verified Module for Storage Account

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Storage Account using AVM
module "storage_account" {
  source  = "Azure/avm-res-storage-storageaccount/azurerm"
  version = "~> 0.2.0"

  enable_telemetry                = var.enable_telemetry
  location                       = var.location
  name                          = var.storage_account_name
  resource_group_name           = var.resource_group_name
  account_kind                  = var.account_kind
  account_tier                  = var.account_tier
  account_replication_type      = var.replication_type
  min_tls_version              = "TLS1_2"
  https_traffic_only_enabled   = true

  # Network rules
  network_rules = var.network_rules_enabled ? {
    default_action = "Deny"
    bypass         = ["AzureServices"]
    ip_rules       = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  } : null

  # Blob properties
  blob_properties = {
    delete_retention_policy = {
      days = var.blob_retention_days
    }
    versioning_enabled = var.blob_versioning_enabled
  }

  tags = var.tags
}