# ==============================================================================
# Environment Configuration - Dev
# ==============================================================================

subscription_id = "00000000-0000-0000-0000-000000000000" # Replace with your subscription ID

project          = "hubspoke"
environment      = "dev"
location         = "eastus"
location_short   = "eus"

tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "HubSpoke"
  CostCenter  = "IT"
}

# ==============================================================================
# Resource Creation Flags
# ==============================================================================

create_hub_resources        = true
create_apm_resources        = true
create_management_resources = true
create_spoke01_resources    = true
create_spoke02_resources    = true
create_iac_resources        = true
create_dns_resources        = true
create_bastion              = true
create_application_gateway  = true
create_api_management       = true
create_monitoring           = true

# ==============================================================================
# Network Configuration
# ==============================================================================

hub_vnet_address_space         = ["10.0.0.0/16"]
apm_vnet_address_space         = ["10.1.0.0/24"]
management_vnet_address_space  = ["10.2.0.0/23"]
spoke01_vnet_address_space     = ["10.10.0.0/23"]
spoke02_vnet_address_space     = ["10.11.0.0/23"]
iac_vnet_address_space         = ["10.20.0.0/24"]
dns_private_vnet_address_space = ["10.30.0.0/24"]
dns_public_vnet_address_space  = ["10.30.1.0/24"]

# ==============================================================================
# VM Configuration
# ==============================================================================

vm_admin_username = "azureadmin"
# vm_admin_password = "" # Set via environment variable TF_VAR_vm_admin_password
vm_size = "Standard_D2s_v3"

# ==============================================================================
# API Management Configuration
# ==============================================================================

apim_sku_name        = "Developer_1"
apim_publisher_name  = "HubSpoke Organization"
apim_publisher_email = "admin@hubspoke.com"

# ==============================================================================
# Application Gateway Configuration
# ==============================================================================

app_gateway_sku_name     = "Standard_v2"
app_gateway_sku_tier     = "Standard_v2"
app_gateway_sku_capacity = 2

# ==============================================================================
# SQL Database Configuration
# ==============================================================================

sql_admin_username = "sqladmin"
# sql_admin_password = "" # Set via environment variable TF_VAR_sql_admin_password
sql_sku_name = "S0"

# ==============================================================================
# Function App Configuration
# ==============================================================================

function_app_runtime = "dotnet"
function_app_version = "8"
