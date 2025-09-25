# Azure Key Vault Module
# Uses Azure Verified Module for Key Vault

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Key Vault using AVM
module "key_vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "~> 0.5.0"

  enable_telemetry    = var.enable_telemetry
  location            = var.location
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
  tenant_id          = var.tenant_id

  # Key Vault configuration
  sku_name                        = var.sku_name
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  # Network access rules
  network_acls = var.network_acls_enabled ? {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    ip_rules                   = var.allowed_ip_addresses
    virtual_network_subnet_ids = var.allowed_subnet_ids
  } : {
    bypass         = "AzureServices"
    default_action = "Allow"
  }

  tags = var.tags
}