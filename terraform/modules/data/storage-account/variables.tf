variable "name" {
  description = "Name of the storage account"
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

variable "account_tier" {
  description = "Storage account tier"
  type        = string
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
