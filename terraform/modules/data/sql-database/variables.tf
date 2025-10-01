variable "server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "sql_version" {
  description = "SQL Server version"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
}

variable "database_name" {
  description = "Database name"
  type        = string
}

variable "database_sku_name" {
  description = "Database SKU name"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
