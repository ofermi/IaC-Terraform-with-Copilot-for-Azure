# Azure Hub-Spoke Network Architecture - Terraform Solution

[![Terraform](https://img.shields.io/badge/Terraform-1.9+-623CE4?logo=terraform)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-Cloud-0078D4?logo=microsoft-azure)](https://azure.microsoft.com/)

## 🏗️ Overview

This repository contains a production-ready Terraform solution for deploying a comprehensive Azure Hub-Spoke network architecture with enterprise-grade security, monitoring, and governance capabilities.

## ✨ Features

- **Hub-Spoke Topology**: Centralized hub VNet with multiple spoke VNets for workload isolation
- **Azure Verified Modules**: Leverages official AVM modules for reliability and best practices
- **Private Connectivity**: Private Endpoints and Private DNS zones for secure PaaS access
- **Secure Access**: Azure Bastion for RDP/SSH without public IP exposure
- **Application Delivery**: Application Gateway with WAF capabilities
- **API Management**: Internal APIM deployment for API governance
- **Monitoring & Logging**: Centralized Log Analytics and Azure Monitor
- **DNS Resolution**: Private DNS Resolver for hybrid scenarios
- **CI/CD Ready**: GitHub Actions workflow for automated deployments
- **Modular Design**: Reusable modules for easy customization

## 📋 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         Hub VNet                            │
│  ┌──────────┐  ┌──────────────┐  ┌────────────────────┐   │
│  │ Bastion  │  │ App Gateway  │  │  DNS Resolver      │   │
│  └──────────┘  └──────────────┘  └────────────────────┘   │
└────────┬────────────┬────────────────────┬──────────────────┘
         │            │                    │
    ┌────┴────┐  ┌────┴────┐         ┌────┴────┐
    │ APM VNet│  │Spoke 01 │         │Spoke 02 │
    │         │  │  VNet   │         │  VNet   │
    │  APIM   │  │         │         │SQL+Func │
    └─────────┘  └─────────┘         └─────────┘
```

For detailed architecture diagram, see [docs/architecture-diagrams/](terraform/docs/architecture-diagrams/)

## 🚀 Quick Start

### Prerequisites

1. **Azure Subscription** with Contributor access
2. **Terraform** >= 1.9.0 ([Download](https://www.terraform.io/downloads))
3. **Azure CLI** ([Installation Guide](https://docs.microsoft.com/cli/azure/install-azure-cli))
4. **Git** for cloning the repository

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd TF-Demo1

# Navigate to environment
cd terraform/environments/dev

# Set environment variables
export TF_VAR_subscription_id="your-subscription-id"
export TF_VAR_vm_admin_password="SecurePassword123!"
export TF_VAR_sql_admin_password="SecurePassword123!"

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Deploy infrastructure
terraform apply
```

## 📁 Repository Structure

```
TF-Demo1/
├── .github/
│   └── workflows/          # GitHub Actions CI/CD pipelines
├── terraform/
│   ├── environments/
│   │   └── dev/           # Development environment configuration
│   ├── modules/           # Reusable Terraform modules
│   └── docs/              # Documentation and architecture diagrams
└── context.txt            # Project context and guidelines
```

## 🔧 Configuration

### Key Configuration Files

- **`terraform.tfvars`**: Environment-specific values (regions, sizes, address spaces)
- **`variables.tf`**: Variable declarations with defaults
- **`locals.tf`**: Centralized resource naming and configuration
- **`resources.tf`**: Resource definitions and module calls

### Customization

Edit `terraform/environments/dev/terraform.tfvars`:

```hcl
# Update your subscription ID
subscription_id = "your-subscription-id-here"

# Modify network address spaces
hub_vnet_address_space = ["10.0.0.0/16"]

# Toggle features
create_bastion             = true
create_application_gateway = true
create_api_management      = true

# Adjust SKUs for cost optimization
app_gateway_sku_name = "Standard_v2"
vm_size              = "Standard_D2s_v3"
```

## 📦 Deployed Resources

| Resource Type | Count | Purpose |
|--------------|-------|---------|
| Resource Groups | 8 | Logical organization |
| Virtual Networks | 8 | Network segmentation |
| Subnets | 20+ | Workload isolation |
| VNet Peerings | 10 | Hub-spoke connectivity |
| Azure Bastion | 1 | Secure VM access |
| Application Gateway | 1 | Load balancing & WAF |
| API Management | 1 | API gateway |
| Virtual Machines | 3 | Bastion hosts & agents |
| SQL Database | 1 | Data storage |
| Function App | 1 | Serverless compute |
| Private Endpoints | 3+ | Secure PaaS access |
| Private DNS Zones | 9 | Internal name resolution |
| DNS Resolver | 1 | Hybrid DNS |
| Log Analytics | 1 | Centralized logging |
| Storage Account | 1 | Terraform state |

## 🔐 Security Features

- ✅ Network isolation via Hub-Spoke topology
- ✅ Private Endpoints for PaaS services
- ✅ No public IPs on backend resources
- ✅ Azure Bastion for secure administration
- ✅ Private DNS for internal resolution
- ✅ Centralized monitoring and logging
- ✅ VNet integration for Function Apps
- ✅ Internal-only API Management

## 📊 Monitoring

All resources are connected to a centralized Log Analytics Workspace with:

- Azure Monitor diagnostics
- Activity logging
- Resource health monitoring
- Custom alerting (configurable)

## 💰 Cost Estimation

Approximate monthly costs (East US, Dev environment):

| Resource | Estimated Cost |
|----------|---------------|
| Virtual Networks | Free |
| Azure Bastion (Standard) | ~$140 |
| Application Gateway (Standard_v2) | ~$150 |
| API Management (Developer) | ~$50 |
| Virtual Machines (3x D2s_v3) | ~$280 |
| SQL Database (S0) | ~$15 |
| Function App (Consumption) | Variable |
| Storage & Misc | ~$10 |
| **Total** | **~$645/month** |

> 💡 Costs can be optimized by adjusting SKUs and deallocating non-production VMs.

## 🔄 CI/CD Pipeline

Automated deployment via GitHub Actions:

- **Pull Request**: Runs `terraform plan` and comments results
- **Merge to Main**: Deploys infrastructure with approval
- **Manual Trigger**: On-demand deployments

Setup instructions: [.github/workflows/README.md](.github/workflows/README.md)

## 📚 Documentation

- **[Implementation Guide](terraform/docs/implementation-guide.md)**: Detailed deployment instructions
- **[Solution Structure](terraform/docs/solution-structure.md)**: Architecture and module documentation
- **[CI/CD Setup](.github/workflows/README.md)**: GitHub Actions configuration

## 🛠️ Modules

All modules use Azure Verified Modules (AVM) where available:

- `resource-group`: AVM Resource Group
- `virtual-network`: AVM Virtual Network
- `bastion`: AVM Bastion Host
- `api-management`: AVM API Management
- `virtual-machine`: AVM Compute VM
- `storage-account`: AVM Storage Account
- `sql-database`: AVM SQL Server
- `log-analytics`: AVM Log Analytics

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test locally
4. Submit a pull request
5. Wait for automated checks
6. Get approval and merge

## 📝 License

This project is provided as-is for educational and production use.

## 🆘 Support

For issues and questions:

- **Azure Documentation**: https://docs.microsoft.com/azure
- **Terraform Registry**: https://registry.terraform.io
- **Azure Verified Modules**: https://azure.github.io/Azure-Verified-Modules/

## ⚠️ Important Notes

1. **Replace Placeholder Values**: Update subscription ID in `terraform.tfvars`
2. **Set Passwords**: Use environment variables for sensitive values
3. **Review Costs**: Understand pricing before deployment
4. **Backup State**: Ensure Terraform state backend is configured
5. **Test First**: Deploy to dev environment before production

## 🎯 Next Steps

After deployment:

1. ✅ Review deployed resources in Azure Portal
2. ✅ Configure NSG rules as needed
3. ✅ Set up custom DNS forwarding
4. ✅ Configure Application Gateway backends
5. ✅ Deploy applications to spoke VNets
6. ✅ Set up custom monitoring alerts
7. ✅ Configure backup policies

---

**Built with ❤️ using Terraform and Azure Verified Modules**
