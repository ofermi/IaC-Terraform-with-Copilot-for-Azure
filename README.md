# Azure Landing Zone - Terraform Solution

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoft-azure&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)

## Overview

This repository contains a complete Terraform solution for deploying an Azure Landing Zone with a hub-spoke network architecture. The solution is production-ready, follows Azure best practices, and leverages Azure Verified Modules (AVM) wherever possible.

## Architecture

### Hub-Spoke Topology

The solution implements a hub-spoke network architecture with:

- **1 Hub VNet (10.0.0.0/16)**: Central connectivity and shared services
  - Azure Firewall
  - Application Gateway (WAF)
  - Azure Bastion
  - Log Analytics Workspace
  - DNS Resolver

- **6 Spoke VNets**: Isolated workload environments
  - APIM Spoke (10.1.0.0/24): API Management
  - Management Spoke (10.2.0.0/24): Management VMs
  - Spoke 01 (10.3.0.0/24): Example workload
  - Spoke 02 (10.4.0.0/24): Function App + SQL Database
  - IaC Spoke (10.5.0.0/24): Terraform State + Agent VM
  - DNS Spoke (10.6.0.0/24): DNS services

### Key Features

✅ **Hub-Spoke Network**: Centralized security and connectivity  
✅ **Azure Firewall**: Network security and traffic inspection  
✅ **Application Gateway**: Web application load balancing with WAF  
✅ **Private Endpoints**: Secure access to PaaS services  
✅ **Private DNS Zones**: DNS resolution for private endpoints  
✅ **API Management**: Internal API gateway  
✅ **Azure Bastion**: Secure VM access without public IPs  
✅ **Log Analytics**: Centralized logging and monitoring  
✅ **Function App**: Serverless compute with VNet integration  
✅ **SQL Database**: Managed database with private connectivity  

## Repository Structure

```
.
├── .github/
│   └── workflows/
│       ├── terraform-cicd.yml        # CI/CD pipeline
│       └── README.md                 # CI/CD documentation
│
├── terraform/
│   ├── environments/
│   │   └── dev/
│   │       ├── main.tf               # Terraform & provider config
│   │       ├── resources.tf          # Resource deployments
│   │       ├── locals.tf             # Configuration & feature flags
│   │       ├── variables.tf          # Variable definitions
│   │       ├── terraform.tfvars      # Variable values
│   │       └── outputs.tf            # Outputs
│   │
│   ├── modules/                      # Reusable Terraform modules
│   │   ├── network/                  # Network modules
│   │   ├── security/                 # Security modules
│   │   ├── compute/                  # Compute modules
│   │   ├── management/               # Management modules
│   │   ├── data/                     # Data modules
│   │   └── integration/              # Integration modules
│   │
│   └── docs/
│       ├── architecture-diagrams/    # Architecture diagrams
│       ├── solution-structure.md     # Structure documentation
│       └── implementation-guide.md   # Deployment guide
│
├── context.txt                       # Project context
└── README.md                         # This file
```

## Prerequisites

- **Azure Subscription**: Active subscription with Contributor access
- **Azure CLI**: Version 2.50.0 or later
- **Terraform**: Version 1.9.0 or later
- **Git**: For version control

## Quick Start

### 1. Clone Repository

```powershell
cd c:\Users\ofermironi\Downloads\TF-Demo5
```

### 2. Authenticate to Azure

```powershell
az login
az account set --subscription "<your-subscription-id>"
```

### 3. Review Configuration

Edit `terraform/environments/dev/terraform.tfvars`:
- Update project name, environment, location
- Review network address spaces
- Customize tags

### 4. Initialize Terraform

```powershell
cd terraform\environments\dev
terraform init
```

### 5. Plan Deployment

```powershell
terraform plan
```

### 6. Deploy

```powershell
terraform apply
```

⏱️ **Estimated Time**: 45-60 minutes (API Management takes 30-45 min)

## Configuration

### Feature Flags

Enable/disable resources in `locals.tf`:

```hcl
locals {
  create_azure_firewall      = true
  create_application_gateway = true
  create_api_management      = true
  create_function_app        = true
  create_sql_database        = true
  # ... etc
}
```

### Network Customization

Modify network address spaces in `terraform.tfvars`:

```hcl
hub_vnet_address_space = ["10.0.0.0/16"]
spoke01_vnet_address_space = ["10.3.0.0/24"]
# ... etc
```

### Resource Naming

Naming convention is defined in `locals.tf`:
```
<resource-type>-<project>-<environment>-<location-short>-<purpose>
```

Example: `rg-demo-dev-we-hub`

## Azure Verified Modules

This solution uses the following AVM modules:

- `Azure/avm-res-operationalinsights-workspace/azurerm` - Log Analytics
- `Azure/avm-res-network-virtualnetwork/azurerm` - Virtual Network
- `Azure/avm-res-network-azurefirewall/azurerm` - Azure Firewall
- `Azure/avm-res-storage-storageaccount/azurerm` - Storage Account
- `Azure/avm-res-sql-server/azurerm` - SQL Server
- `Azure/avm-res-apimanagement-service/azurerm` - API Management

## CI/CD Pipeline

GitHub Actions workflow provides:

✅ **Terraform Validation**: Format check and syntax validation  
✅ **Terraform Plan**: Automated planning on PRs with comment  
✅ **Terraform Apply**: Automatic deployment on merge to main  
✅ **Security Scanning**: Checkov integration for IaC security  
✅ **Environment Protection**: Production approval gates  

See [.github/workflows/README.md](.github/workflows/README.md) for setup instructions.

## Documentation

- **[Solution Structure](terraform/docs/solution-structure.md)**: Complete directory structure
- **[Implementation Guide](terraform/docs/implementation-guide.md)**: Detailed deployment guide
- **[CI/CD Setup](.github/workflows/README.md)**: GitHub Actions configuration

## Network Traffic Flow

```
User
  ↓
Application Gateway (Public IP)
  ↓
Azure Firewall (Inspection)
  ↓
API Management (Internal)
  ↓
Function App (VNet Integrated)
  ↓
SQL Database (Private Endpoint)
```

## Security Features

🔒 **Network Security**
- All spoke traffic routed through Azure Firewall
- Network Security Groups on all subnets
- No public IPs on workload resources

🔒 **Private Connectivity**
- Private endpoints for PaaS services
- Private DNS zones for name resolution
- No public access to databases/storage

🔒 **Identity & Access**
- Azure Bastion for secure VM access
- Service principal for Terraform deployment
- RBAC at resource group level

🔒 **Monitoring**
- Centralized Log Analytics Workspace
- Azure Monitor for alerts
- Diagnostic settings on all resources

## Cost Optimization

Key cost drivers:
- **API Management Developer SKU**: ~$50/month
- **Azure Firewall**: ~$1.25/hour
- **Application Gateway WAF_v2**: ~$0.45/hour
- **Azure Bastion Standard**: ~$0.19/hour
- **Virtual Machines**: Varies by size
- **SQL Database S0**: ~$15/month

**Total Estimated Cost (Dev)**: ~$700-900/month

💡 **Tip**: Use feature flags in `locals.tf` to disable expensive resources during development.

## Troubleshooting

### Common Issues

**API Management Timeout**
- API Management takes 30-45 minutes to deploy
- This is normal Azure behavior

**VNet Peering Conflicts**
- Ensure no overlapping address spaces
- Check on-premises connectivity for conflicts

**Private Endpoint DNS**
- Verify Private DNS Zone links to VNets
- Check DNS resolution from VMs

### Debug Mode

Enable Terraform debugging:
```powershell
$env:TF_LOG="DEBUG"
terraform apply
```

## Cleanup

Destroy all resources:

```powershell
terraform destroy
```

⚠️ **Warning**: This will delete all resources. Ensure you have backups.

## Support & Contribution

### Issues
Report issues via GitHub Issues

### Contributing
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.

## Resources

- [Azure Landing Zones](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

## Authors

Infrastructure Team

## Acknowledgments

- Azure Verified Modules team
- HashiCorp Terraform team
- Azure Cloud Adoption Framework team

---

**Built with ❤️ using Terraform and Azure**
