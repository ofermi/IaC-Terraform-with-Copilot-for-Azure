# Azure Backup Module Variables

variable "location" {
  description = "Azure region where the Recovery Services Vault will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vault_name" {
  description = "Name of the Recovery Services Vault"
  type        = string
}

variable "vault_sku" {
  description = "SKU for the Recovery Services Vault"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "RS0"], var.vault_sku)
    error_message = "Vault SKU must be Standard or RS0."
  }
}

variable "soft_delete_enabled" {
  description = "Enable soft delete for the vault"
  type        = bool
  default     = true
}

variable "cross_region_restore_enabled" {
  description = "Enable cross region restore"
  type        = bool
  default     = false
}

variable "storage_mode_type" {
  description = "Storage mode type for the vault"
  type        = string
  default     = "GeoRedundant"
  
  validation {
    condition = contains([
      "GeoRedundant", "LocallyRedundant", "ZoneRedundant"
    ], var.storage_mode_type)
    error_message = "Storage mode type must be GeoRedundant, LocallyRedundant, or ZoneRedundant."
  }
}

# VM Backup Configuration
variable "enable_vm_backup" {
  description = "Enable VM backup policy creation"
  type        = bool
  default     = true
}

variable "vm_backup_policy_name" {
  description = "Name of the VM backup policy"
  type        = string
  default     = "vm-backup-policy"
}

variable "backup_frequency" {
  description = "Backup frequency (Daily or Weekly)"
  type        = string
  default     = "Daily"
  
  validation {
    condition     = contains(["Daily", "Weekly"], var.backup_frequency)
    error_message = "Backup frequency must be Daily or Weekly."
  }
}

variable "backup_time" {
  description = "Time of day for backup (HH:MM format)"
  type        = string
  default     = "23:00"
}

variable "backup_weekdays" {
  description = "Weekdays for backup (when frequency is Weekly)"
  type        = list(string)
  default     = ["Sunday"]
}

variable "daily_retention_count" {
  description = "Number of days to retain daily backups"
  type        = number
  default     = 30
}

variable "weekly_retention_count" {
  description = "Number of weeks to retain weekly backups (0 to disable)"
  type        = number
  default     = 12
}

variable "weekly_retention_weekdays" {
  description = "Weekdays for weekly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "monthly_retention_count" {
  description = "Number of months to retain monthly backups (0 to disable)"
  type        = number
  default     = 12
}

variable "monthly_retention_weekdays" {
  description = "Weekdays for monthly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "monthly_retention_weeks" {
  description = "Weeks for monthly retention"
  type        = list(string)
  default     = ["First"]
}

variable "yearly_retention_count" {
  description = "Number of years to retain yearly backups (0 to disable)"
  type        = number
  default     = 7
}

variable "yearly_retention_weekdays" {
  description = "Weekdays for yearly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "yearly_retention_weeks" {
  description = "Weeks for yearly retention"
  type        = list(string)
  default     = ["First"]
}

variable "yearly_retention_months" {
  description = "Months for yearly retention"
  type        = list(string)
  default     = ["January"]
}

# File Share Backup Configuration
variable "enable_file_share_backup" {
  description = "Enable file share backup policy creation"
  type        = bool
  default     = false
}

variable "file_share_backup_policy_name" {
  description = "Name of the file share backup policy"
  type        = string
  default     = "file-share-backup-policy"
}

variable "file_share_backup_frequency" {
  description = "File share backup frequency"
  type        = string
  default     = "Daily"
}

variable "file_share_backup_time" {
  description = "Time of day for file share backup"
  type        = string
  default     = "23:00"
}

variable "file_share_daily_retention_count" {
  description = "Number of days to retain daily file share backups"
  type        = number
  default     = 30
}

variable "file_share_weekly_retention_count" {
  description = "Number of weeks to retain weekly file share backups (0 to disable)"
  type        = number
  default     = 0
}

variable "file_share_weekly_retention_weekdays" {
  description = "Weekdays for file share weekly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "file_share_monthly_retention_count" {
  description = "Number of months to retain monthly file share backups (0 to disable)"
  type        = number
  default     = 0
}

variable "file_share_monthly_retention_weekdays" {
  description = "Weekdays for file share monthly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "file_share_monthly_retention_weeks" {
  description = "Weeks for file share monthly retention"
  type        = list(string)
  default     = ["First"]
}

variable "file_share_yearly_retention_count" {
  description = "Number of years to retain yearly file share backups (0 to disable)"
  type        = number
  default     = 0
}

variable "file_share_yearly_retention_weekdays" {
  description = "Weekdays for file share yearly retention"
  type        = list(string)
  default     = ["Sunday"]
}

variable "file_share_yearly_retention_weeks" {
  description = "Weeks for file share yearly retention"
  type        = list(string)
  default     = ["First"]
}

variable "file_share_yearly_retention_months" {
  description = "Months for file share yearly retention"
  type        = list(string)
  default     = ["January"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}