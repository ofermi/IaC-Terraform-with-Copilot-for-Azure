# ==============================================================================
# Local Variables - Resource Naming and Configuration
# ==============================================================================

locals {
  # Naming conventions
  resource_group_naming = {
    hub        = "rg-${var.project}-${var.environment}-${var.location_short}-hub-001"
    apm        = "rg-${var.project}-${var.environment}-${var.location_short}-apm-001"
    management = "rg-${var.project}-${var.environment}-${var.location_short}-mgmt-001"
    spoke01    = "rg-${var.project}-${var.environment}-${var.location_short}-spoke01-001"
    spoke02    = "rg-${var.project}-${var.environment}-${var.location_short}-spoke02-001"
    iac        = "rg-${var.project}-${var.environment}-${var.location_short}-iac-001"
    dns        = "rg-${var.project}-${var.environment}-${var.location_short}-dns-001"
    governance = "rg-${var.project}-${var.environment}-${var.location_short}-governance-001"
  }

  # VNet configurations
  vnet_config = {
    hub = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-hub-001"
      address_space = var.hub_vnet_address_space
      subnets = {
        intranet_dns = {
          name             = "snet-intranet-dns-001"
          address_prefixes = ["10.0.1.0/24"]
        }
        private_link = {
          name             = "snet-private-link-001"
          address_prefixes = ["10.0.2.0/24"]
        }
        application_gateway = {
          name             = "snet-app-gateway-001"
          address_prefixes = ["10.0.3.0/24"]
        }
        monitor = {
          name             = "snet-monitor-001"
          address_prefixes = ["10.0.4.0/24"]
        }
        bastion = {
          name             = "AzureBastionSubnet"
          address_prefixes = ["10.0.5.0/27"]
        }
        private_endpoint = {
          name             = "snet-private-endpoint-001"
          address_prefixes = ["10.0.6.0/24"]
        }
        outbound_dns = {
          name             = "snet-outbound-dns-001"
          address_prefixes = ["10.0.7.0/24"]
        }
      }
    }

    apm = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-apm-001"
      address_space = var.apm_vnet_address_space
      subnets = {
        apm = {
          name             = "snet-apm-001"
          address_prefixes = ["10.1.0.0/25"]
        }
      }
    }

    management = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-mgmt-001"
      address_space = var.management_vnet_address_space
      subnets = {
        management = {
          name             = "snet-mgmt-001"
          address_prefixes = ["10.2.0.0/24"]
        }
      }
    }

    spoke01 = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-spoke01-001"
      address_space = var.spoke01_vnet_address_space
      subnets = {
        db = {
          name             = "snet-db-001"
          address_prefixes = ["10.10.0.0/24"]
        }
        app_pe = {
          name             = "snet-app-pe-001"
          address_prefixes = ["10.10.1.0/25"]
        }
        integration = {
          name             = "snet-integration-001"
          address_prefixes = ["10.10.1.128/25"]
        }
      }
    }

    spoke02 = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-spoke02-001"
      address_space = var.spoke02_vnet_address_space
      subnets = {
        integration = {
          name             = "snet-integration-001"
          address_prefixes = ["10.11.0.0/24"]
        }
        app_pe = {
          name             = "snet-app-pe-001"
          address_prefixes = ["10.11.1.0/25"]
        }
        db_pe = {
          name             = "snet-db-pe-001"
          address_prefixes = ["10.11.1.128/25"]
        }
      }
    }

    iac = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-iac-001"
      address_space = var.iac_vnet_address_space
      subnets = {
        agent_vm = {
          name             = "snet-agent-vm-001"
          address_prefixes = ["10.20.0.0/25"]
        }
      }
    }

    dns_private = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-dns-private-001"
      address_space = var.dns_private_vnet_address_space
      subnets = {
        dns_private = {
          name             = "snet-dns-private-001"
          address_prefixes = ["10.30.0.0/25"]
        }
      }
    }

    dns_public = {
      name          = "vnet-${var.project}-${var.environment}-${var.location_short}-dns-public-001"
      address_space = var.dns_public_vnet_address_space
      subnets = {
        dns_public = {
          name             = "snet-dns-public-001"
          address_prefixes = ["10.30.1.0/25"]
        }
      }
    }
  }

  # Bastion configuration
  bastion_config = {
    name = "bas-${var.project}-${var.environment}-${var.location_short}-001"
    sku  = "Standard"
  }

  # API Management configuration
  apim_config = {
    name           = "apim-${var.project}-${var.environment}-${var.location_short}-001"
    sku_name       = var.apim_sku_name
    publisher_name = var.apim_publisher_name
    publisher_email = var.apim_publisher_email
  }

  # Application Gateway configuration
  app_gateway_config = {
    name             = "agw-${var.project}-${var.environment}-${var.location_short}-001"
    sku_name         = var.app_gateway_sku_name
    sku_tier         = var.app_gateway_sku_tier
    sku_capacity     = var.app_gateway_sku_capacity
    public_ip_name   = "pip-agw-${var.project}-${var.environment}-${var.location_short}-001"
  }

  # VM configurations
  vm_config = {
    bastion_mgmt = {
      name               = "vm-bastion-mgmt-${var.environment}-001"
      size               = var.vm_size
      admin_username     = var.vm_admin_username
    }
    bastion_apm = {
      name               = "vm-bastion-apm-${var.environment}-001"
      size               = var.vm_size
      admin_username     = var.vm_admin_username
    }
    agent = {
      name               = "vm-agent-${var.environment}-001"
      size               = var.vm_size
      admin_username     = var.vm_admin_username
    }
  }

  # SQL Database configuration
  sql_config = {
    server_name   = "sql-${var.project}-${var.environment}-${var.location_short}-001"
    database_name = "sqldb-${var.project}-${var.environment}-${var.location_short}-001"
    admin_username = var.sql_admin_username
    sku_name      = var.sql_sku_name
  }

  # Function App configuration
  function_app_config = {
    name              = "func-${var.project}-${var.environment}-${var.location_short}-001"
    storage_account   = "stfunc${var.project}${var.environment}${var.location_short}001"
    service_plan_name = "asp-func-${var.project}-${var.environment}-${var.location_short}-001"
    runtime           = var.function_app_runtime
    version           = var.function_app_version
  }

  # Storage Account for Terraform State
  tfstate_storage_config = {
    name                = "st${var.project}${var.environment}${var.location_short}001"
    account_tier        = "Standard"
    replication_type    = "LRS"
    container_name      = "tfstate"
  }

  # Log Analytics Workspace
  log_analytics_config = {
    name              = "log-${var.project}-${var.environment}-${var.location_short}-001"
    sku               = "PerGB2018"
    retention_in_days = 30
  }

  # Private DNS Zones
  private_dns_zones = [
    "privatelink.database.windows.net",
    "privatelink.blob.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.azurewebsites.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.azurecr.io",
    "privatelink.azure-api.net"
  ]

  # DNS Resolver configuration
  dns_resolver_config = {
    name = "dnspr-${var.project}-${var.environment}-${var.location_short}-001"
  }

  # VNet Peering configurations
  peering_config = {
    hub_to_apm = {
      name                      = "peer-hub-to-apm"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
      use_remote_gateways       = false
    }
    apm_to_hub = {
      name                      = "peer-apm-to-hub"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = false
      use_remote_gateways       = false
    }
    hub_to_management = {
      name                      = "peer-hub-to-mgmt"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
      use_remote_gateways       = false
    }
    management_to_hub = {
      name                      = "peer-mgmt-to-hub"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = false
      use_remote_gateways       = false
    }
    hub_to_spoke01 = {
      name                      = "peer-hub-to-spoke01"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
      use_remote_gateways       = false
    }
    spoke01_to_hub = {
      name                      = "peer-spoke01-to-hub"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = false
      use_remote_gateways       = false
    }
    hub_to_spoke02 = {
      name                      = "peer-hub-to-spoke02"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
      use_remote_gateways       = false
    }
    spoke02_to_hub = {
      name                      = "peer-spoke02-to-hub"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = false
      use_remote_gateways       = false
    }
    hub_to_iac = {
      name                      = "peer-hub-to-iac"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = true
      use_remote_gateways       = false
    }
    iac_to_hub = {
      name                      = "peer-iac-to-hub"
      allow_virtual_network_access = true
      allow_forwarded_traffic   = true
      allow_gateway_transit     = false
      use_remote_gateways       = false
    }
  }

  # Common tags merged with resource-specific tags
  common_tags = merge(
    var.tags,
    {
      DeployedBy = "Terraform"
      DeployDate = timestamp()
    }
  )
}
