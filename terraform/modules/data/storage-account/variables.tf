variable "enable_telemetry" {
  description = "Enable telemetry for the module"
  type        = bool
  default     = true
}

variable "location" {
  description = "Azure location for the storage account"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "account_kind" {
  description = "Kind of storage account"
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "Performance tier of the storage account"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Replication type for the storage account"
  type        = string
  default     = "LRS"
}

variable "network_rules_enabled" {
  description = "Enable network rules for the storage account"
  type        = bool
  default     = false
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges"
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "List of allowed subnet IDs"
  type        = list(string)
  default     = []
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}