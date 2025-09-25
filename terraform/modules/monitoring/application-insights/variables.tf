# Application Insights Module Variables

variable "location" {
  description = "Azure region where the Application Insights will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "app_insights_name" {
  description = "Name of the Application Insights instance"
  type        = string
}

variable "workspace_id" {
  description = "ID of the Log Analytics workspace to link"
  type        = string
}

variable "application_type" {
  description = "Type of application being monitored"
  type        = string
  default     = "web"
  
  validation {
    condition = contains([
      "ios", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "web"
    ], var.application_type)
    error_message = "Application type must be one of: ios, java, MobileCenter, Node.JS, other, phone, store, web."
  }
}

variable "retention_in_days" {
  description = "Retention period in days for Application Insights data"
  type        = number
  default     = 90
  
  validation {
    condition = contains([
      30, 60, 90, 120, 180, 270, 365, 550, 730
    ], var.retention_in_days)
    error_message = "Retention period must be one of: 30, 60, 90, 120, 180, 270, 365, 550, 730."
  }
}

variable "daily_data_cap_in_gb" {
  description = "Daily data volume cap in GB"
  type        = number
  default     = 100
}

variable "daily_data_cap_notifications_disabled" {
  description = "Disable daily data cap notifications"
  type        = bool
  default     = false
}

variable "sampling_percentage" {
  description = "Sampling percentage for telemetry"
  type        = number
  default     = 100
  
  validation {
    condition     = var.sampling_percentage >= 0 && var.sampling_percentage <= 100
    error_message = "Sampling percentage must be between 0 and 100."
  }
}

variable "disable_ip_masking" {
  description = "Disable IP address masking"
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Enable internet ingestion"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Enable internet query"
  type        = bool
  default     = true
}

variable "force_customer_storage_for_profiler" {
  description = "Force customer storage for profiler"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}