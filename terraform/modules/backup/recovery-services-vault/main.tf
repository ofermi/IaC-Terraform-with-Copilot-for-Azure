# Azure Backup Module

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Recovery Services Vault
resource "azurerm_recovery_services_vault" "main" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vault_sku
  
  # Soft delete and security settings
  soft_delete_enabled = var.soft_delete_enabled
  
  # Cross region restore
  cross_region_restore_enabled = var.cross_region_restore_enabled
  
  # Storage mode redundancy
  storage_mode_type = var.storage_mode_type
  
  tags = var.tags
}

# Backup Policy for VMs
resource "azurerm_backup_policy_vm" "main" {
  count               = var.enable_vm_backup ? 1 : 0
  name                = var.vm_backup_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.main.name

  # Backup schedule
  backup {
    frequency = var.backup_frequency
    time      = var.backup_time
    weekdays  = var.backup_weekdays
  }

  # Retention policy
  retention_daily {
    count = var.daily_retention_count
  }

  dynamic "retention_weekly" {
    for_each = var.weekly_retention_count > 0 ? [1] : []
    content {
      count    = var.weekly_retention_count
      weekdays = var.weekly_retention_weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.monthly_retention_count > 0 ? [1] : []
    content {
      count    = var.monthly_retention_count
      weekdays = var.monthly_retention_weekdays
      weeks    = var.monthly_retention_weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.yearly_retention_count > 0 ? [1] : []
    content {
      count    = var.yearly_retention_count
      weekdays = var.yearly_retention_weekdays
      weeks    = var.yearly_retention_weeks
      months   = var.yearly_retention_months
    }
  }
}

# Backup Policy for File Shares
resource "azurerm_backup_policy_file_share" "main" {
  count               = var.enable_file_share_backup ? 1 : 0
  name                = var.file_share_backup_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.main.name

  # Backup schedule
  backup {
    frequency = var.file_share_backup_frequency
    time      = var.file_share_backup_time
  }

  # Retention policy
  retention_daily {
    count = var.file_share_daily_retention_count
  }

  dynamic "retention_weekly" {
    for_each = var.file_share_weekly_retention_count > 0 ? [1] : []
    content {
      count    = var.file_share_weekly_retention_count
      weekdays = var.file_share_weekly_retention_weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = var.file_share_monthly_retention_count > 0 ? [1] : []
    content {
      count    = var.file_share_monthly_retention_count
      weekdays = var.file_share_monthly_retention_weekdays
      weeks    = var.file_share_monthly_retention_weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = var.file_share_yearly_retention_count > 0 ? [1] : []
    content {
      count    = var.file_share_yearly_retention_count
      weekdays = var.file_share_yearly_retention_weekdays
      weeks    = var.file_share_yearly_retention_weeks
      months   = var.file_share_yearly_retention_months
    }
  }
}