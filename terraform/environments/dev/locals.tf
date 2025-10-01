# ============================================================================
# Feature Flags - Control which resources to create
# ============================================================================

locals {
  # Feature flags to enable/disable resource creation
  create_resource_groups      = true
  create_hub_vnet             = true
  create_apim_vnet            = true
  create_mgmt_vnet            = true
  create_spoke01_vnet         = true
  create_spoke02_vnet         = true
  create_iac_vnet             = true
  create_dns_vnet             = true
  create_vnet_peerings        = true
  create_azure_firewall       = true
  create_application_gateway  = true
  create_api_management       = true
  create_azure_bastion        = true
  create_bastion_vm           = true
  create_agent_vm             = true
  create_log_analytics        = true
  create_sql_database         = true
  create_function_app         = true
  create_private_dns_zones    = true
  create_private_endpoints    = true
  create_dns_resolver         = true
  create_storage_account      = true
  create_monitoring           = true

  # ============================================================================
  # Resource Group Configurations
  # ============================================================================

  resource_groups = {
    hub = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-hub"
      location = var.location
      tags     = var.tags
    }
    apim = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-apim"
      location = var.location
      tags     = var.tags
    }
    mgmt = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-mgmt"
      location = var.location
      tags     = var.tags
    }
    spoke01 = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-spoke01"
      location = var.location
      tags     = var.tags
    }
    spoke02 = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-spoke02"
      location = var.location
      tags     = var.tags
    }
    iac = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-iac"
      location = var.location
      tags     = var.tags
    }
    dns = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-dns"
      location = var.location
      tags     = var.tags
    }
    governance = {
      name     = "rg-${var.project}-${var.environment}-${var.location_short}-governance"
      location = var.location
      tags     = var.tags
    }
  }

  # ============================================================================
  # Virtual Network Configurations
  # ============================================================================

  vnets = {
    hub = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-hub"
      resource_group_name = local.resource_groups.hub.name
      location            = var.location
      address_space       = var.hub_vnet_address_space
      subnets             = var.hub_subnets
      tags                = var.tags
    }
    apim = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-apim"
      resource_group_name = local.resource_groups.apim.name
      location            = var.location
      address_space       = var.apim_vnet_address_space
      subnets             = var.apim_subnets
      tags                = var.tags
    }
    mgmt = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-mgmt"
      resource_group_name = local.resource_groups.mgmt.name
      location            = var.location
      address_space       = var.mgmt_vnet_address_space
      subnets             = var.mgmt_subnets
      tags                = var.tags
    }
    spoke01 = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-spoke01"
      resource_group_name = local.resource_groups.spoke01.name
      location            = var.location
      address_space       = var.spoke01_vnet_address_space
      subnets             = var.spoke01_subnets
      tags                = var.tags
    }
    spoke02 = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-spoke02"
      resource_group_name = local.resource_groups.spoke02.name
      location            = var.location
      address_space       = var.spoke02_vnet_address_space
      subnets             = var.spoke02_subnets
      tags                = var.tags
    }
    iac = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-iac"
      resource_group_name = local.resource_groups.iac.name
      location            = var.location
      address_space       = var.iac_vnet_address_space
      subnets             = var.iac_subnets
      tags                = var.tags
    }
    dns = {
      name                = "vnet-${var.project}-${var.environment}-${var.location_short}-dns"
      resource_group_name = local.resource_groups.dns.name
      location            = var.location
      address_space       = var.dns_vnet_address_space
      subnets             = var.dns_subnets
      tags                = var.tags
    }
  }

  # ============================================================================
  # Azure Firewall Configuration
  # ============================================================================

  azure_firewall = {
    name                = "afw-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.hub.name
    location            = var.location
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
    tags                = var.tags
  }

  # ============================================================================
  # Application Gateway Configuration
  # ============================================================================

  application_gateway = {
    name                = "agw-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.hub.name
    location            = var.location
    sku_name            = "WAF_v2"
    sku_tier            = "WAF_v2"
    sku_capacity        = 2
    tags                = var.tags
  }

  # ============================================================================
  # API Management Configuration
  # ============================================================================

  api_management = {
    name                = "apim-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.apim.name
    location            = var.location
    publisher_name      = "Demo Organization"
    publisher_email     = "admin@demo.com"
    sku_name            = "Developer_1"
    tags                = var.tags
  }

  # ============================================================================
  # Azure Bastion Configuration
  # ============================================================================

  azure_bastion = {
    name                = "bas-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.hub.name
    location            = var.location
    sku                 = "Standard"
    tags                = var.tags
  }

  # ============================================================================
  # Virtual Machine Configurations
  # ============================================================================

  virtual_machines = {
    bastion_vm = {
      name                = "vm-${var.project}-${var.environment}-${var.location_short}-bastion"
      resource_group_name = local.resource_groups.mgmt.name
      location            = var.location
      size                = "Standard_D2s_v3"
      admin_username      = "azureadmin"
      os_type             = "Windows"
      tags                = var.tags
    }
    agent_vm = {
      name                = "vm-${var.project}-${var.environment}-${var.location_short}-agent"
      resource_group_name = local.resource_groups.iac.name
      location            = var.location
      size                = "Standard_D2s_v3"
      admin_username      = "azureadmin"
      os_type             = "Linux"
      tags                = var.tags
    }
  }

  # ============================================================================
  # Log Analytics Workspace Configuration
  # ============================================================================

  log_analytics = {
    name                = "log-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.hub.name
    location            = var.location
    sku                 = "PerGB2018"
    retention_in_days   = 30
    tags                = var.tags
  }

  # ============================================================================
  # SQL Database Configuration
  # ============================================================================

  sql_server = {
    name                         = "sql-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name          = local.resource_groups.spoke02.name
    location                     = var.location
    version                      = "12.0"
    administrator_login          = "sqladmin"
    minimum_tls_version          = "1.2"
    public_network_access_enabled = false
    tags                         = var.tags
  }

  sql_database = {
    name      = "sqldb-${var.project}-${var.environment}-${var.location_short}-main"
    server_id = "sql-${var.project}-${var.environment}-${var.location_short}"
    sku_name  = "S0"
    tags      = var.tags
  }

  # ============================================================================
  # Function App Configuration
  # ============================================================================

  function_app = {
    name                = "func-${var.project}-${var.environment}-${var.location_short}-app"
    resource_group_name = local.resource_groups.spoke02.name
    location            = var.location
    runtime             = "dotnet"
    tags                = var.tags
  }

  # ============================================================================
  # Storage Account Configuration (for TF State and Function App)
  # ============================================================================

  storage_accounts = {
    tfstate = {
      name                     = "st${var.project}${var.environment}${var.location_short}tfstate"
      resource_group_name      = local.resource_groups.iac.name
      location                 = var.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
      tags                     = var.tags
    }
    function = {
      name                     = "st${var.project}${var.environment}${var.location_short}func"
      resource_group_name      = local.resource_groups.spoke02.name
      location                 = var.location
      account_tier             = "Standard"
      account_replication_type = "LRS"
      tags                     = var.tags
    }
  }

  # ============================================================================
  # Private DNS Zones Configuration
  # ============================================================================

  private_dns_zones = {
    blob = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = local.resource_groups.dns.name
      tags                = var.tags
    }
    sql = {
      name                = "privatelink.database.windows.net"
      resource_group_name = local.resource_groups.dns.name
      tags                = var.tags
    }
    sites = {
      name                = "privatelink.azurewebsites.net"
      resource_group_name = local.resource_groups.dns.name
      tags                = var.tags
    }
    vault = {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = local.resource_groups.dns.name
      tags                = var.tags
    }
  }

  # ============================================================================
  # DNS Resolver Configuration
  # ============================================================================

  dns_resolver = {
    name                = "dnspr-${var.project}-${var.environment}-${var.location_short}"
    resource_group_name = local.resource_groups.dns.name
    location            = var.location
    tags                = var.tags
  }

  # ============================================================================
  # Monitoring Configuration
  # ============================================================================

  monitoring = {
    resource_group_name = local.resource_groups.governance.name
    location            = var.location
    tags                = var.tags
  }
}
