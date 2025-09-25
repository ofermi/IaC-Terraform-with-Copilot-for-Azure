# SQL Database Module Variables

variable "enable_telemetry" {
  description = "Enable telemetry for Azure Verified Module"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure region where the SQL Server and Database will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# SQL Server Variables
variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login for the SQL Server"
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "server_version" {
  description = "Version of the SQL Server"
  type        = string
  default     = "12.0"
  
  validation {
    condition     = contains(["12.0"], var.server_version)
    error_message = "Server version must be 12.0."
  }
}

# Azure AD Administrator
variable "azuread_administrator" {
  description = "Azure AD administrator configuration"
  type = object({
    login_username = string
    object_id      = string
  })
  default = null
}

# Firewall Rules
variable "firewall_rules" {
  description = "Map of firewall rules for the SQL Server"
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}

# Database Variables
variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "database_collation" {
  description = "Collation of the SQL Database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" {
  description = "License type for the database"
  type        = string
  default     = "LicenseIncluded"
  
  validation {
    condition     = contains(["LicenseIncluded", "BasePrice"], var.license_type)
    error_message = "License type must be LicenseIncluded or BasePrice."
  }
}

variable "max_size_gb" {
  description = "Maximum size of the database in GB"
  type        = number
  default     = 32
}

variable "read_scale" {
  description = "Enable read scale-out"
  type        = bool
  default     = false
}

variable "database_sku" {
  description = "SKU for the SQL Database"
  type        = string
  default     = "S0"
}

variable "zone_redundant" {
  description = "Enable zone redundancy for the database"
  type        = bool
  default     = false
}

variable "auto_pause_delay_in_minutes" {
  description = "Time in minutes after which database is automatically paused (for serverless)"
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "Minimal capacity for serverless database"
  type        = number
  default     = null
}

# Backup Configuration
variable "backup_retention_days" {
  description = "Point in time restore retention days"
  type        = number
  default     = 7
  
  validation {
    condition     = var.backup_retention_days >= 1 && var.backup_retention_days <= 35
    error_message = "Backup retention days must be between 1 and 35."
  }
}

variable "enable_long_term_retention" {
  description = "Enable long-term retention policy"
  type        = bool
  default     = false
}

variable "weekly_retention" {
  description = "Weekly backup retention period"
  type        = string
  default     = "P1W"
}

variable "monthly_retention" {
  description = "Monthly backup retention period"
  type        = string
  default     = "P1M"
}

variable "yearly_retention" {
  description = "Yearly backup retention period"
  type        = string
  default     = "P1Y"
}

variable "week_of_year" {
  description = "Week of year to take yearly backup"
  type        = number
  default     = 1
  
  validation {
    condition     = var.week_of_year >= 1 && var.week_of_year <= 52
    error_message = "Week of year must be between 1 and 52."
  }
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}