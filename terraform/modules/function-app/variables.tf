variable "name" {
  description = "Name of the function app"
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

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "service_plan_name" {
  description = "Service plan name"
  type        = string
}

variable "runtime_stack" {
  description = "Runtime stack"
  type        = string
  default     = "dotnet"
}

variable "runtime_version" {
  description = "Runtime version"
  type        = string
  default     = "8"
}

variable "subnet_id" {
  description = "Subnet ID for VNet integration"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
