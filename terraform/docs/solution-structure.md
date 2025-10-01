# Azure Landing Zone - Terraform Solution Structure

## Overview
This document describes the complete directory structure of the Terraform solution for Azure Landing Zone deployment.

## Directory Tree

```
terraform/
├── environments/
│   └── dev/
│       ├── main.tf                    # Terraform & provider configuration
│       ├── resources.tf               # All resources deployment using modules
│       ├── locals.tf                  # Feature flags & all configurations/settings
│       ├── variables.tf               # Variable type definitions (no defaults)
│       ├── terraform.tfvars           # Project config, Tags, Network spaces
│       └── outputs.tf                 # Output definitions
│
├── modules/
│   ├── network/                       # Network-related modules
│   │   ├── virtual-network/          # VNet and Subnets
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── vnet-peering/             # VNet Peering
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── private-dns-zones/        # Private DNS Zones
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── dns-resolver/             # DNS Resolver
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   ├── security/                      # Security-related modules
│   │   ├── azure-firewall/           # Azure Firewall
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── application-gateway/      # Application Gateway
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── bastion/                  # Azure Bastion
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   ├── compute/                       # Compute-related modules
│   │   ├── virtual-machines/         # Virtual Machines
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── function-app/             # Function App
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   ├── management/                    # Management-related modules
│   │   ├── resource-groups/          # Resource Groups
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── log-analytics/            # Log Analytics Workspace
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── monitoring/               # Monitoring & Alerts
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   ├── data/                          # Data-related modules
│   │   ├── sql-database/             # SQL Database
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── storage-account/          # Storage Account
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   │
│   └── integration/                   # Integration-related modules
│       ├── api-management/           # API Management
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       └── private-endpoints/        # Private Endpoints
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
└── docs/
    ├── architecture-diagrams/        # Architecture diagrams
    ├── solution-structure.md         # This file
    └── implementation-guide.md       # Implementation guide
```

## Key Design Principles

### 1. Module Organization
Modules are grouped by their functional category:
- **network**: All networking-related resources
- **security**: Security services (Firewall, Gateway, Bastion)
- **compute**: Compute resources (VMs, Function Apps)
- **management**: Resource management and monitoring
- **data**: Data storage and databases
- **integration**: Integration services (APIM, Private Endpoints)

### 2. Environment Structure
- Each environment (dev, staging, prod) has its own directory
- Configuration is centralized in `locals.tf`
- Variables are defined in `variables.tf` (types only)
- Values are provided in `terraform.tfvars`

### 3. Configuration Management
- **Feature Flags**: Controlled in `locals.tf` to enable/disable resources
- **Centralized Settings**: All resource configurations in `locals.tf`
- **No Hard-Coded Values**: Modules read from `locals.tf`
- **Type-Safe Variables**: Variables defined with types, no defaults

### 4. Deployment Orchestration
- `resources.tf` is the single deployment file
- All module calls are in `resources.tf`
- Dependencies are explicitly managed
- Resources are grouped with clear comments

## Azure Verified Modules (AVM) Usage

The solution leverages Azure Verified Modules where available:
- **Log Analytics Workspace**: `Azure/avm-res-operationalinsights-workspace/azurerm`
- **Virtual Network**: `Azure/avm-res-network-virtualnetwork/azurerm`
- **Azure Firewall**: `Azure/avm-res-network-azurefirewall/azurerm`
- **Storage Account**: `Azure/avm-res-storage-storageaccount/azurerm`
- **SQL Server**: `Azure/avm-res-sql-server/azurerm`
- **API Management**: `Azure/avm-res-apimanagement-service/azurerm`

For resources not yet available in AVM, custom modules follow Terraform best practices.

## Resource Naming Convention

All resources follow a consistent naming pattern:
```
<resource-type>-<project>-<environment>-<location-short>-<purpose/serial>
```

Examples:
- Resource Group: `rg-demo-dev-we-hub`
- Virtual Network: `vnet-demo-dev-we-hub`
- Azure Firewall: `afw-demo-dev-we`
- Application Gateway: `agw-demo-dev-we`

## Next Steps

1. Review `implementation-guide.md` for deployment instructions
2. Customize `terraform.tfvars` for your environment
3. Initialize Terraform with `terraform init`
4. Plan deployment with `terraform plan`
5. Deploy with `terraform apply`
