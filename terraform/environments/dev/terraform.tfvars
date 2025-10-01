# ============================================================================
# Project Configuration
# ============================================================================
project         = "demo"
environment     = "dev"
location        = "westeurope"
location_short  = "we"

# ============================================================================
# Tags
# ============================================================================
tags = {
  Project     = "demo"
  Environment = "dev"
  ManagedBy   = "Terraform"
  Owner       = "Infrastructure Team"
  CostCenter  = "IT"
}

# ============================================================================
# Network Address Spaces
# ============================================================================

# Hub VNet
hub_vnet_address_space = ["10.0.0.0/16"]

hub_subnets = {
  firewall = {
    name             = "AzureFirewallSubnet"
    address_prefixes = ["10.0.1.0/24"]
  }
  bastion = {
    name             = "AzureBastionSubnet"
    address_prefixes = ["10.0.2.0/27"]
  }
  appgateway = {
    name             = "snet-demo-dev-we-appgateway"
    address_prefixes = ["10.0.3.0/24"]
  }
  monitor = {
    name             = "snet-demo-dev-we-monitor"
    address_prefixes = ["10.0.4.0/24"]
  }
  inbounddns = {
    name             = "snet-demo-dev-we-inbounddns"
    address_prefixes = ["10.0.5.0/24"]
  }
  outbounddns = {
    name             = "snet-demo-dev-we-outbounddns"
    address_prefixes = ["10.0.6.0/24"]
  }
  pe = {
    name             = "snet-demo-dev-we-pe"
    address_prefixes = ["10.0.7.0/24"]
  }
}

# APIM VNet
apim_vnet_address_space = ["10.1.0.0/24"]

apim_subnets = {
  apim = {
    name             = "snet-demo-dev-we-apim"
    address_prefixes = ["10.1.0.0/27"]
  }
}

# Management VNet
mgmt_vnet_address_space = ["10.2.0.0/24"]

mgmt_subnets = {
  mgmt = {
    name             = "snet-demo-dev-we-mgmt"
    address_prefixes = ["10.2.0.0/27"]
  }
}

# Spoke 01 VNet
spoke01_vnet_address_space = ["10.3.0.0/24"]

spoke01_subnets = {
  dbvpe = {
    name             = "snet-demo-dev-we-spoke01-dbvpe"
    address_prefixes = ["10.3.0.0/27"]
  }
  apppe = {
    name             = "snet-demo-dev-we-spoke01-apppe"
    address_prefixes = ["10.3.0.64/27"]
  }
  integration = {
    name             = "snet-demo-dev-we-spoke01-integration"
    address_prefixes = ["10.3.0.128/27"]
  }
}

# Spoke 02 VNet
spoke02_vnet_address_space = ["10.4.0.0/24"]

spoke02_subnets = {
  integration = {
    name             = "snet-demo-dev-we-spoke02-integration"
    address_prefixes = ["10.4.0.0/27"]
  }
  apppe = {
    name             = "snet-demo-dev-we-spoke02-apppe"
    address_prefixes = ["10.4.0.64/27"]
  }
  dbvpe = {
    name             = "snet-demo-dev-we-spoke02-dbvpe"
    address_prefixes = ["10.4.0.128/27"]
  }
}

# IaC VNet
iac_vnet_address_space = ["10.5.0.0/24"]

iac_subnets = {
  vm = {
    name             = "snet-demo-dev-we-iac-vm"
    address_prefixes = ["10.5.0.0/27"]
  }
  pe = {
    name             = "snet-demo-dev-we-iac-pe"
    address_prefixes = ["10.5.0.64/27"]
  }
}

# DNS VNet
dns_vnet_address_space = ["10.6.0.0/24"]

dns_subnets = {
  inbound = {
    name             = "snet-demo-dev-we-dns-inbound"
    address_prefixes = ["10.6.0.0/27"]
  }
  outbound = {
    name             = "snet-demo-dev-we-dns-outbound"
    address_prefixes = ["10.6.0.64/27"]
  }
}
