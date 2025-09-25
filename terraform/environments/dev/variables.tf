# Variables for Contoso Ltd Terraform Configuration

# =============================================================================
# PROJECT CONFIGURATION
# =============================================================================

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "contoso"
  
  validation {
    condition     = length(var.project_name) >= 2 && length(var.project_name) <= 10
    error_message = "Project name must be between 2 and 10 characters."
  }
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, test, staging, or prod."
  }
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "DevOps Team"
}

# =============================================================================
# AZURE CONFIGURATION
# =============================================================================

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "location_short_names" {
  description = "Short names for Azure regions"
  type        = map(string)
  default = {
    "East US"          = "eus"
    "East US 2"        = "eus2"
    "West US"          = "wus"
    "West US 2"        = "wus2"
    "Central US"       = "cus"
    "North Central US" = "ncus"
    "South Central US" = "scus"
    "West Central US"  = "wcus"
    "Canada Central"   = "cac"
    "Canada East"      = "cae"
    "Brazil South"     = "brs"
    "North Europe"     = "neu"
    "West Europe"      = "weu"
    "UK South"         = "uks"
    "UK West"          = "ukw"
    "France Central"   = "frc"
    "Germany West Central" = "gwc"
    "Switzerland North" = "swn"
    "Norway East"      = "noe"
    "Southeast Asia"   = "sea"
    "East Asia"        = "eas"
    "Australia East"   = "aue"
    "Australia Southeast" = "aus"
    "Japan East"       = "jpe"
    "Japan West"       = "jpw"
    "Korea Central"    = "krc"
    "Korea South"      = "krs"
    "India Central"    = "inc"
    "India South"      = "ins"
    "India West"       = "inw"
  }
}

# =============================================================================
# RESOURCE DEPLOYMENT TOGGLES
# =============================================================================

variable "deploy_hub_vnet" {
  description = "Deploy Hub Virtual Network (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_hub_vnet == 0 || var.deploy_hub_vnet == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_spoke_vnets" {
  description = "Deploy Spoke Virtual Networks (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_spoke_vnets == 0 || var.deploy_spoke_vnets == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_vnet_peering" {
  description = "Deploy VNet Peering (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_vnet_peering == 0 || var.deploy_vnet_peering == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_virtual_machines" {
  description = "Deploy Virtual Machines (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_virtual_machines == 0 || var.deploy_virtual_machines == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_app_services" {
  description = "Deploy App Services (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_app_services == 0 || var.deploy_app_services == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_sql_database" {
  description = "Deploy SQL Database (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_sql_database == 0 || var.deploy_sql_database == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_storage_accounts" {
  description = "Deploy Storage Accounts (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_storage_accounts == 0 || var.deploy_storage_accounts == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_key_vault" {
  description = "Deploy Key Vault (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_key_vault == 0 || var.deploy_key_vault == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_monitoring" {
  description = "Deploy Monitoring Resources (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_monitoring == 0 || var.deploy_monitoring == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_application_gateway" {
  description = "Deploy Application Gateway (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_application_gateway == 0 || var.deploy_application_gateway == 1
    error_message = "Value must be 0 or 1."
  }
}

variable "deploy_cdn" {
  description = "Deploy CDN Profile (0=no, 1=yes)"
  type        = number
  default     = 1
  
  validation {
    condition     = var.deploy_cdn == 0 || var.deploy_cdn == 1
    error_message = "Value must be 0 or 1."
  }
}

# =============================================================================
# NETWORKING CONFIGURATION
# =============================================================================

variable "hub_vnet_address_space" {
  description = "Address space for Hub VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "spoke1_vnet_address_space" {
  description = "Address space for Spoke VNet 1 (Application Tier)"
  type        = list(string)
  default     = ["10.1.0.0/16"]
}

variable "spoke2_vnet_address_space" {
  description = "Address space for Spoke VNet 2 (Data Tier)"
  type        = list(string)
  default     = ["10.2.0.0/16"]
}

variable "management_vnet_address_space" {
  description = "Address space for Management VNet"
  type        = list(string)
  default     = ["10.3.0.0/16"]
}

# =============================================================================
# COMPUTE CONFIGURATION
# =============================================================================

variable "vm_size" {
  description = "Size of Virtual Machines"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_admin_username" {
  description = "Admin username for Virtual Machines"
  type        = string
  default     = "azureuser"
}

variable "app_service_plan_sku" {
  description = "SKU for App Service Plan"
  type        = string
  default     = "B1"
}

# =============================================================================
# DATABASE CONFIGURATION
# =============================================================================

variable "sql_database_sku" {
  description = "SKU for SQL Database"
  type        = string
  default     = "S2"
}

variable "sql_admin_username" {
  description = "Admin username for SQL Server"
  type        = string
  default     = "sqladmin"
}

# =============================================================================
# STORAGE CONFIGURATION
# =============================================================================

variable "storage_account_tier" {
  description = "Storage Account performance tier"
  type        = string
  default     = "Standard"
  
  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "Storage account tier must be Standard or Premium."
  }
}

variable "storage_account_replication_type" {
  description = "Storage Account replication type"
  type        = string
  default     = "LRS"
  
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_account_replication_type)
    error_message = "Invalid storage replication type."
  }
}

# =============================================================================
# DETAILED DEPLOYMENT TOGGLES
# =============================================================================

variable "deploy_hub_network" {
  description = "Deploy Hub Network (true/false)"
  type        = bool
  default     = true
}

variable "deploy_spoke_app_network" {
  description = "Deploy Spoke App Network (true/false)"
  type        = bool
  default     = true
}

variable "deploy_spoke_data_network" {
  description = "Deploy Spoke Data Network (true/false)"
  type        = bool
  default     = true
}

variable "deploy_management_resources" {
  description = "Deploy Management Resources (true/false)"
  type        = bool
  default     = true
}

variable "deploy_web_vms" {
  description = "Deploy Web Tier VMs (true/false)"
  type        = bool
  default     = true
}

variable "deploy_app_vms" {
  description = "Deploy App Tier VMs (true/false)"
  type        = bool
  default     = true
}

# =============================================================================
# NETWORK ADDRESS SPACES
# =============================================================================

variable "hub_vnet_address_space" {
  description = "Address space for Hub VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "hub_gateway_subnet_prefix" {
  description = "Gateway subnet prefix for Hub VNet"
  type        = string
  default     = "10.0.1.0/27"
}

variable "hub_firewall_subnet_prefix" {
  description = "Firewall subnet prefix for Hub VNet"
  type        = string
  default     = "10.0.2.0/26"
}

variable "hub_shared_services_subnet_prefix" {
  description = "Shared services subnet prefix for Hub VNet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "spoke_app_vnet_address_space" {
  description = "Address space for App Spoke VNet"
  type        = string
  default     = "10.1.0.0/16"
}

variable "spoke_app_web_subnet_prefix" {
  description = "Web subnet prefix for App Spoke VNet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "spoke_app_app_subnet_prefix" {
  description = "App subnet prefix for App Spoke VNet"
  type        = string
  default     = "10.1.2.0/24"
}

variable "spoke_app_pe_subnet_prefix" {
  description = "Private endpoint subnet prefix for App Spoke VNet"
  type        = string
  default     = "10.1.3.0/24"
}

variable "spoke_data_vnet_address_space" {
  description = "Address space for Data Spoke VNet"
  type        = string
  default     = "10.2.0.0/16"
}

variable "spoke_data_db_subnet_prefix" {
  description = "Database subnet prefix for Data Spoke VNet"
  type        = string
  default     = "10.2.1.0/24"
}

variable "spoke_data_storage_subnet_prefix" {
  description = "Storage subnet prefix for Data Spoke VNet"
  type        = string
  default     = "10.2.2.0/24"
}

# =============================================================================
# VM CONFIGURATION
# =============================================================================

variable "web_vm_size" {
  description = "Size for Web Tier VMs"
  type        = string
  default     = "Standard_B2s"
}

variable "app_vm_size" {
  description = "Size for App Tier VMs"
  type        = string
  default     = "Standard_B2s"
}

# =============================================================================
# STORAGE CONFIGURATION ADDITIONAL
# =============================================================================

variable "storage_replication_type" {
  description = "Storage Account replication type"
  type        = string
  default     = "LRS"
}

variable "storage_network_rules_enabled" {
  description = "Enable network rules for storage account"
  type        = bool
  default     = false
}

variable "blob_retention_days" {
  description = "Blob retention period in days"
  type        = number
  default     = 7
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

# =============================================================================
# FRONT DOOR CONFIGURATION
# =============================================================================

variable "deploy_front_door" {
  description = "Deploy Azure Front Door (true/false)"
  type        = bool
  default     = true
}

variable "front_door_sku" {
  description = "Azure Front Door SKU"
  type        = string
  default     = "Standard_AzureFrontDoor"
  
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku)
    error_message = "SKU must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
}

variable "enable_waf" {
  description = "Enable Web Application Firewall on Front Door"
  type        = bool
  default     = true
}

variable "waf_mode" {
  description = "WAF mode - Detection or Prevention"
  type        = string
  default     = "Prevention"
  
  validation {
    condition     = contains(["Detection", "Prevention"], var.waf_mode)
    error_message = "WAF mode must be Detection or Prevention."
  }
}

variable "front_door_health_probe_path" {
  description = "Health probe path for Front Door"
  type        = string
  default     = "/"
}

# =============================================================================
# SECURITY CONFIGURATION
# =============================================================================

variable "deploy_key_vault" {
  description = "Deploy Azure Key Vault (true/false)"
  type        = bool
  default     = true
}

variable "key_vault_public_access_enabled" {
  description = "Enable public network access to Key Vault"
  type        = bool
  default     = true
}

variable "key_vault_allowed_ip_ranges" {
  description = "List of allowed IP ranges for Key Vault access"
  type        = list(string)
  default     = []
}

variable "key_vault_access_policies" {
  description = "Access policies for Key Vault"
  type = map(object({
    tenant_id          = string
    object_id          = string
    key_permissions    = optional(list(string), [])
    secret_permissions = optional(list(string), [])
    certificate_permissions = optional(list(string), [])
  }))
  default = {}
}

# Network Security Groups
variable "deploy_network_security_groups" {
  description = "Deploy Network Security Groups (true/false)"
  type        = bool
  default     = true
}

variable "hub_nsg_rules" {
  description = "Security rules for Hub NSG"
  type = map(object({
    access                     = string
    direction                 = string
    priority                  = number
    protocol                  = string
    source_port_range         = optional(string)
    source_port_ranges        = optional(list(string))
    destination_port_range    = optional(string)
    destination_port_ranges   = optional(list(string))
    source_address_prefix     = optional(string)
    source_address_prefixes   = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
    description               = optional(string)
  }))
  default = {
    "allow-rdp" = {
      access                   = "Allow"
      direction               = "Inbound"
      priority                = 1000
      protocol                = "Tcp"
      destination_port_range  = "3389"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
      description            = "Allow RDP"
    }
  }
}

variable "app_spoke_nsg_rules" {
  description = "Security rules for App Spoke NSG"
  type = map(object({
    access                     = string
    direction                 = string
    priority                  = number
    protocol                  = string
    source_port_range         = optional(string)
    source_port_ranges        = optional(list(string))
    destination_port_range    = optional(string)
    destination_port_ranges   = optional(list(string))
    source_address_prefix     = optional(string)
    source_address_prefixes   = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
    description               = optional(string)
  }))
  default = {
    "allow-http" = {
      access                   = "Allow"
      direction               = "Inbound"
      priority                = 1000
      protocol                = "Tcp"
      destination_port_range  = "80"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
      description            = "Allow HTTP"
    }
    "allow-https" = {
      access                   = "Allow"
      direction               = "Inbound"
      priority                = 1010
      protocol                = "Tcp"
      destination_port_range  = "443"
      source_address_prefix   = "*"
      destination_address_prefix = "*"
      description            = "Allow HTTPS"
    }
  }
}

variable "data_spoke_nsg_rules" {
  description = "Security rules for Data Spoke NSG"
  type = map(object({
    access                     = string
    direction                 = string
    priority                  = number
    protocol                  = string
    source_port_range         = optional(string)
    source_port_ranges        = optional(list(string))
    destination_port_range    = optional(string)
    destination_port_ranges   = optional(list(string))
    source_address_prefix     = optional(string)
    source_address_prefixes   = optional(list(string))
    destination_address_prefix = optional(string)
    destination_address_prefixes = optional(list(string))
    description               = optional(string)
  }))
  default = {
    "allow-sql" = {
      access                   = "Allow"
      direction               = "Inbound"
      priority                = 1000
      protocol                = "Tcp"
      destination_port_range  = "1433"
      source_address_prefix   = "10.1.0.0/16"  # App spoke CIDR
      destination_address_prefix = "*"
      description            = "Allow SQL from App Spoke"
    }
  }
}

# =============================================================================
# DATA CONFIGURATION
# =============================================================================

variable "deploy_sql_database" {
  description = "Deploy Azure SQL Database (true/false)"
  type        = bool
  default     = true
}

variable "sql_admin_username" {
  description = "Administrator username for SQL Server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "Administrator password for SQL Server"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd123!"  # Should be changed in production
}

variable "sql_server_version" {
  description = "Version of SQL Server"
  type        = string
  default     = "12.0"
}

variable "sql_azuread_administrator" {
  description = "Azure AD administrator for SQL Server"
  type = object({
    login_username = string
    object_id      = string
  })
  default = null
}

variable "sql_firewall_rules" {
  description = "Firewall rules for SQL Server"
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {
    "AllowAzureServices" = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

variable "sql_database_sku" {
  description = "SKU for SQL Database"
  type        = string
  default     = "S0"
}

variable "sql_database_max_size_gb" {
  description = "Maximum size of SQL Database in GB"
  type        = number
  default     = 32
}

variable "sql_backup_retention_days" {
  description = "Backup retention days for SQL Database"
  type        = number
  default     = 7
}

variable "sql_enable_long_term_retention" {
  description = "Enable long-term retention for SQL Database"
  type        = bool
  default     = false
}

variable "sql_weekly_retention" {
  description = "Weekly backup retention period"
  type        = string
  default     = "P1W"
}

variable "sql_monthly_retention" {
  description = "Monthly backup retention period"
  type        = string
  default     = "P1M"
}

variable "sql_yearly_retention" {
  description = "Yearly backup retention period"
  type        = string
  default     = "P1Y"
}

# =============================================================================
# MONITORING CONFIGURATION
# =============================================================================

variable "deploy_log_analytics" {
  description = "Deploy Log Analytics Workspace (true/false)"
  type        = bool
  default     = true
}

variable "deploy_application_insights" {
  description = "Deploy Application Insights (true/false)"
  type        = bool
  default     = true
}

variable "application_insights_type" {
  description = "Type of Application Insights"
  type        = string
  default     = "web"
}

variable "application_insights_retention_days" {
  description = "Retention days for Application Insights"
  type        = number
  default     = 90
}

# =============================================================================
# CONTAINER CONFIGURATION
# =============================================================================

variable "deploy_container_instances" {
  description = "Deploy Container Instances (true/false)"
  type        = bool
  default     = false
}

variable "container_os_type" {
  description = "Operating system type for containers"
  type        = string
  default     = "Linux"
}

variable "container_restart_policy" {
  description = "Restart policy for containers"
  type        = string
  default     = "Always"
}

variable "container_ip_address_type" {
  description = "IP address type for container group"
  type        = string
  default     = "Public"
}

variable "containers" {
  description = "List of containers to deploy"
  type = list(object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    
    ports = list(object({
      port     = number
      protocol = string
    }))
    
    environment_variables        = optional(map(string))
    secure_environment_variables = optional(map(string))
    commands                    = optional(list(string))
    
    volumes = optional(list(object({
      name                 = string
      mount_path          = string
      read_only           = optional(bool)
      empty_dir           = optional(bool)
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name          = optional(string)
    })))
    
    liveness_probe = optional(object({
      exec                  = optional(list(string))
      initial_delay_seconds = optional(number)
      period_seconds       = optional(number)
      failure_threshold    = optional(number)
      success_threshold    = optional(number)
      timeout_seconds      = optional(number)
      http_get = optional(object({
        path   = string
        port   = number
        scheme = optional(string)
      }))
    }))
    
    readiness_probe = optional(object({
      exec                  = optional(list(string))
      initial_delay_seconds = optional(number)
      period_seconds       = optional(number)
      failure_threshold    = optional(number)
      success_threshold    = optional(number)
      timeout_seconds      = optional(number)
      http_get = optional(object({
        path   = string
        port   = number
        scheme = optional(string)
      }))
    }))
  }))
  default = [
    {
      name   = "nginx"
      image  = "nginx:latest"
      cpu    = 0.5
      memory = 1.5
      ports = [
        {
          port     = 80
          protocol = "TCP"
        }
      ]
    }
  ]
}

# =============================================================================
# BACKUP CONFIGURATION
# =============================================================================

variable "deploy_backup_vault" {
  description = "Deploy Recovery Services Vault for backup (true/false)"
  type        = bool
  default     = true
}

variable "backup_vault_sku" {
  description = "SKU for Recovery Services Vault"
  type        = string
  default     = "Standard"
}

variable "backup_soft_delete_enabled" {
  description = "Enable soft delete for backup vault"
  type        = bool
  default     = true
}

variable "backup_cross_region_restore_enabled" {
  description = "Enable cross region restore"
  type        = bool
  default     = false
}

variable "backup_storage_mode_type" {
  description = "Storage mode type for backup vault"
  type        = string
  default     = "GeoRedundant"
}

# VM Backup Policy Configuration
variable "enable_vm_backup_policy" {
  description = "Enable VM backup policy"
  type        = bool
  default     = true
}

variable "vm_backup_frequency" {
  description = "VM backup frequency"
  type        = string
  default     = "Daily"
}

variable "vm_backup_time" {
  description = "VM backup time"
  type        = string
  default     = "23:00"
}

variable "vm_daily_retention_count" {
  description = "VM daily backup retention count"
  type        = number
  default     = 30
}

variable "vm_weekly_retention_count" {
  description = "VM weekly backup retention count"
  type        = number
  default     = 12
}

variable "vm_monthly_retention_count" {
  description = "VM monthly backup retention count"
  type        = number
  default     = 12
}

variable "vm_yearly_retention_count" {
  description = "VM yearly backup retention count"
  type        = number
  default     = 7
}

# File Share Backup Policy Configuration
variable "enable_file_share_backup_policy" {
  description = "Enable file share backup policy"
  type        = bool
  default     = false
}

variable "file_share_backup_frequency" {
  description = "File share backup frequency"
  type        = string
  default     = "Daily"
}

variable "file_share_daily_retention_count" {
  description = "File share daily backup retention count"
  type        = number
  default     = 30
}