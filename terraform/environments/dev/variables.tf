# ==============================================================================
# General Variables
# ==============================================================================

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "project" {
  description = "Project name used in resource naming"
  type        = string
  default     = "hubspoke"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "location_short" {
  description = "Short name for Azure region"
  type        = string
  default     = "eus"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "HubSpoke"
  }
}

# ==============================================================================
# Resource Creation Flags
# ==============================================================================

variable "create_hub_resources" {
  description = "Create Hub VNet and related resources"
  type        = bool
  default     = true
}

variable "create_apm_resources" {
  description = "Create APM resources"
  type        = bool
  default     = true
}

variable "create_management_resources" {
  description = "Create Management resources"
  type        = bool
  default     = true
}

variable "create_spoke01_resources" {
  description = "Create Spoke 01 resources"
  type        = bool
  default     = true
}

variable "create_spoke02_resources" {
  description = "Create Spoke 02 resources"
  type        = bool
  default     = true
}

variable "create_iac_resources" {
  description = "Create IaC resources"
  type        = bool
  default     = true
}

variable "create_dns_resources" {
  description = "Create DNS resources"
  type        = bool
  default     = true
}

variable "create_bastion" {
  description = "Create Azure Bastion"
  type        = bool
  default     = true
}

variable "create_application_gateway" {
  description = "Create Application Gateway"
  type        = bool
  default     = true
}

variable "create_api_management" {
  description = "Create API Management"
  type        = bool
  default     = true
}

variable "create_monitoring" {
  description = "Create monitoring and diagnostics resources"
  type        = bool
  default     = true
}

# ==============================================================================
# Network Configuration
# ==============================================================================

variable "hub_vnet_address_space" {
  description = "Address space for Hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "apm_vnet_address_space" {
  description = "Address space for APM VNet"
  type        = list(string)
  default     = ["10.1.0.0/24"]
}

variable "management_vnet_address_space" {
  description = "Address space for Management VNet"
  type        = list(string)
  default     = ["10.2.0.0/23"]
}

variable "spoke01_vnet_address_space" {
  description = "Address space for Spoke 01 VNet"
  type        = list(string)
  default     = ["10.10.0.0/23"]
}

variable "spoke02_vnet_address_space" {
  description = "Address space for Spoke 02 VNet"
  type        = list(string)
  default     = ["10.11.0.0/23"]
}

variable "iac_vnet_address_space" {
  description = "Address space for IaC VNet"
  type        = list(string)
  default     = ["10.20.0.0/24"]
}

variable "dns_private_vnet_address_space" {
  description = "Address space for DNS Private VNet"
  type        = list(string)
  default     = ["10.30.0.0/24"]
}

variable "dns_public_vnet_address_space" {
  description = "Address space for DNS Public VNet"
  type        = list(string)
  default     = ["10.30.1.0/24"]
}

# ==============================================================================
# VM Configuration
# ==============================================================================

variable "vm_admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureadmin"
}

variable "vm_admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_D2s_v3"
}

# ==============================================================================
# API Management Configuration
# ==============================================================================

variable "apim_sku_name" {
  description = "SKU for API Management"
  type        = string
  default     = "Developer_1"
}

variable "apim_publisher_name" {
  description = "Publisher name for API Management"
  type        = string
  default     = "HubSpoke Organization"
}

variable "apim_publisher_email" {
  description = "Publisher email for API Management"
  type        = string
  default     = "admin@hubspoke.com"
}

# ==============================================================================
# Application Gateway Configuration
# ==============================================================================

variable "app_gateway_sku_name" {
  description = "SKU name for Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "app_gateway_sku_tier" {
  description = "SKU tier for Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "app_gateway_sku_capacity" {
  description = "SKU capacity for Application Gateway"
  type        = number
  default     = 2
}

# ==============================================================================
# SQL Database Configuration
# ==============================================================================

variable "sql_admin_username" {
  description = "Administrator username for SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_sku_name" {
  description = "SKU name for SQL Database"
  type        = string
  default     = "S0"
}

# ==============================================================================
# Function App Configuration
# ==============================================================================

variable "function_app_runtime" {
  description = "Runtime stack for Function App"
  type        = string
  default     = "dotnet"
}

variable "function_app_version" {
  description = "Runtime version for Function App"
  type        = string
  default     = "8"
}
