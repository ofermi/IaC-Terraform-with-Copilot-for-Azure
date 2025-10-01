# Azure Hub-Spoke Architecture - Terraform Solution

## Overview

This Terraform solution deploys a comprehensive Azure Hub-Spoke network architecture with security, monitoring, and governance capabilities.

## Architecture Components

### Resource Groups
- **Hub Resource Group**: Core networking infrastructure
- **APM Resource Group**: API Management resources
- **Management Resource Group**: Management and bastion VMs
- **Spoke 01 Resource Group**: Application spoke 1
- **Spoke 02 Resource Group**: Application spoke 2 with SQL and Function App
- **IaC Resource Group**: Terraform state storage and agent VM
- **DNS Resource Group**: Private DNS zones and DNS resolver
- **Governance Resource Group**: Monitoring and logging

### Network Infrastructure
- **Hub VNet** (10.0.0.0/16)
  - Intranet DNS Subnet
  - Private Link Subnet
  - Application Gateway Subnet
  - Monitor Subnet
  - Azure Bastion Subnet
  - Private Endpoint Subnet
  - Outbound DNS Subnet

- **APM VNet** (10.1.0.0/24)
  - API Management Subnet

- **Management VNet** (10.2.0.0/23)
  - Management Subnet

- **Spoke 01 VNet** (10.10.0.0/23)
  - Database Subnet
  - App Private Endpoint Subnet
  - Integration Subnet

- **Spoke 02 VNet** (10.11.0.0/23)
  - Integration Subnet
  - App Private Endpoint Subnet
  - DB Private Endpoint Subnet

- **IaC VNet** (10.20.0.0/24)
  - Agent VM Subnet

- **DNS Private VNet** (10.30.0.0/24)
  - DNS Private Subnet

- **DNS Public VNet** (10.30.1.0/24)
  - DNS Public Subnet

### Key Services

#### Hub Resources
- **Azure Bastion**: Secure RDP/SSH connectivity
- **Application Gateway**: Web application firewall and load balancing
- **VNet Peering**: Hub-to-spoke connectivity

#### APM Resources
- **API Management**: API gateway and management (Internal VNet mode)

#### Spoke 02 Resources
- **Azure SQL Database**: Managed database service
- **Function App**: Serverless compute with VNet integration
- **Private Endpoints**: Secure connectivity to PaaS services

#### DNS Resources
- **Private DNS Zones**: Name resolution for Azure services
- **DNS Private Resolver**: Hybrid DNS resolution

#### Governance
- **Log Analytics Workspace**: Centralized logging
- **Azure Monitor**: Diagnostics and alerting

## Prerequisites

1. **Azure Subscription**: Active Azure subscription
2. **Terraform**: Version >= 1.9.0
3. **Azure CLI**: Authenticated to your subscription
4. **Permissions**: Contributor access to the subscription

## Configuration

### Environment Variables

Set the following sensitive variables as environment variables:

```powershell
# PowerShell
$env:TF_VAR_subscription_id = "your-subscription-id"
$env:TF_VAR_vm_admin_password = "your-vm-password"
$env:TF_VAR_sql_admin_password = "your-sql-password"
```

### Terraform Variables

Edit `terraform/environments/dev/terraform.tfvars` to customize:

- Project name
- Environment
- Azure region
- Network address spaces
- SKUs and sizing
- Feature flags

## Directory Structure

```
terraform/
├── environments/
│   └── dev/
│       ├── main.tf              # Provider configuration
│       ├── resources.tf         # Resource definitions
│       ├── locals.tf            # Local variables
│       ├── variables.tf         # Variable declarations
│       ├── terraform.tfvars     # Environment values
│       └── outputs.tf           # Outputs
├── modules/                     # Reusable modules
└── docs/                        # Documentation
```

## Deployment Instructions

### 1. Initialize Terraform

```powershell
cd terraform/environments/dev
terraform init
```

### 2. Validate Configuration

```powershell
terraform validate
```

### 3. Plan Deployment

```powershell
terraform plan -out=tfplan
```

### 4. Apply Configuration

```powershell
terraform apply tfplan
```

## Module Documentation

All modules follow Azure Verified Modules (AVM) standards where available:

- **resource-group**: Uses AVM resource group module
- **virtual-network**: Uses AVM virtual network module
- **bastion**: Uses AVM Bastion module
- **api-management**: Uses AVM API Management module
- **log-analytics**: Uses AVM Log Analytics module
- **virtual-machine**: Uses AVM virtual machine module
- **storage-account**: Uses AVM storage account module
- **sql-database**: Uses AVM SQL Server module

## Security Features

- **Network Isolation**: Hub-spoke topology with controlled peering
- **Private Endpoints**: Secure connectivity to PaaS services
- **Azure Bastion**: Secure VM access without public IPs
- **Private DNS**: Internal name resolution
- **Network Security Groups**: Traffic filtering (configurable)
- **Monitoring**: Centralized logging and diagnostics

## Naming Conventions

Resources follow Azure naming best practices:

- Resource Groups: `rg-{project}-{env}-{location}-{purpose}-{serial}`
- VNets: `vnet-{project}-{env}-{location}-{purpose}-{serial}`
- Subnets: `snet-{purpose}-{serial}`
- VMs: `vm-{purpose}-{env}-{serial}`

## Cost Optimization

- SKUs are configurable via variables
- Resource creation can be toggled with feature flags
- Default configurations use cost-effective options

## Maintenance

### Updating Resources

Modify `terraform.tfvars` or `locals.tf` and run:

```powershell
terraform plan
terraform apply
```

### Adding New Spokes

1. Define VNet configuration in `locals.tf`
2. Add VNet module in `resources.tf`
3. Add peering configurations
4. Update outputs

### Destroying Resources

```powershell
terraform destroy
```

## Support

For issues or questions, refer to:
- [Azure Documentation](https://docs.microsoft.com/azure)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)

## Version History

- **v1.0**: Initial hub-spoke architecture implementation

## License

This Terraform configuration is provided as-is for use in Azure environments.
