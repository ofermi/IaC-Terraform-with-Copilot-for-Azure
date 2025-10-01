# Azure Landing Zone - Implementation Guide

## Overview
This guide provides comprehensive instructions for deploying the Azure Landing Zone using Terraform.

## Architecture Summary

### Hub-Spoke Network Topology
The solution implements a hub-spoke network architecture with:
- **1 Hub VNet**: Central connectivity and security services
- **6 Spoke VNets**: Isolated workload environments
- **VNet Peering**: All spokes connected to the hub

### Resource Groups
1. **Hub**: Azure Firewall, Application Gateway, Azure Bastion, Log Analytics
2. **APIM**: API Management service
3. **Management**: Management VMs
4. **Spoke 01**: Example workload with private endpoints
5. **Spoke 02**: Function App and SQL Database
6. **IaC**: Terraform state and agent VM
7. **DNS**: Private DNS Resolver and zones
8. **Governance**: Monitoring and security

### Key Components

#### Network Services
- **Azure Firewall**: Centralized network security (10.0.1.0/24)
- **Application Gateway**: Web application load balancer (10.0.3.0/24)
- **Azure Bastion**: Secure VM access (10.0.2.0/27)
- **Private DNS Resolver**: DNS resolution for private endpoints

#### Application Services
- **API Management**: Internal API gateway
- **Function App**: Serverless compute with VNet integration
- **SQL Database**: Managed database with private endpoint

#### Management & Monitoring
- **Log Analytics Workspace**: Centralized logging
- **Azure Monitor**: Alerts and diagnostics
- **Virtual Machines**: Bastion and agent VMs

## Prerequisites

1. **Azure Subscription**: Active subscription with Owner or Contributor access
2. **Azure CLI**: Version 2.50.0 or later
3. **Terraform**: Version 1.9.0 or later
4. **Authentication**: Azure CLI logged in or service principal configured

## Deployment Steps

### Step 1: Clone or Navigate to Repository
```powershell
cd c:\Users\ofermironi\Downloads\TF-Demo5\terraform\environments\dev
```

### Step 2: Authenticate to Azure
```powershell
az login
az account set --subscription "<your-subscription-id>"
```

### Step 3: Review Configuration

#### terraform.tfvars
Review and customize the following sections:
- **Project Configuration**: Project name, environment, location
- **Tags**: Resource tagging for organization
- **Network Address Spaces**: VNet and subnet CIDR blocks

#### locals.tf
Review feature flags to enable/disable resources:
```hcl
create_resource_groups      = true
create_hub_vnet             = true
create_azure_firewall       = true
# ... etc
```

### Step 4: Initialize Terraform
```powershell
terraform init
```

This will:
- Download required providers (Azure RM, Random)
- Initialize backend configuration
- Download Azure Verified Modules

### Step 5: Validate Configuration
```powershell
terraform validate
```

### Step 6: Plan Deployment
```powershell
terraform plan -out=tfplan
```

Review the plan carefully. The deployment will create approximately:
- 8 Resource Groups
- 7 Virtual Networks
- 12 VNet Peerings
- 4 Private DNS Zones
- Azure Firewall, Application Gateway, Azure Bastion
- API Management
- 2 Virtual Machines
- SQL Server and Database
- Function App
- Storage Accounts
- Private Endpoints
- Log Analytics and Monitoring

### Step 7: Apply Deployment
```powershell
terraform apply tfplan
```

⏱️ **Estimated Deployment Time**: 45-60 minutes
- API Management alone takes 30-45 minutes
- Azure Firewall and Application Gateway take 10-15 minutes each

### Step 8: Verify Deployment
```powershell
# List all resource groups
az group list --output table --query "[?starts_with(name,'rg-demo-dev')]"

# Get outputs
terraform output
```

## Post-Deployment Configuration

### 1. Configure Azure Firewall Rules
The Azure Firewall is deployed but requires custom rules:
```powershell
# Add application rules
az network firewall application-rule create \
  --resource-group rg-demo-dev-we-hub \
  --firewall-name afw-demo-dev-we \
  --collection-name "AllowWeb" \
  --name "AllowHTTP" \
  --protocols Http=80 Https=443 \
  --source-addresses "*" \
  --target-fqdns "*.microsoft.com" "*.azure.com"
```

### 2. Configure Application Gateway Backend Pools
Add backend targets to Application Gateway:
```powershell
az network application-gateway address-pool update \
  --resource-group rg-demo-dev-we-hub \
  --gateway-name agw-demo-dev-we \
  --name defaultbackendpool \
  --servers <backend-ip-or-fqdn>
```

### 3. Deploy API Management APIs
Configure APIs in API Management through Azure Portal or CLI

### 4. Deploy Function App Code
Deploy your function app code:
```powershell
func azure functionapp publish func-demo-dev-we-app
```

### 5. Configure Remote State (Optional)
After initial deployment, configure remote state:

1. Uncomment backend configuration in `main.tf`:
```hcl
backend "azurerm" {
  resource_group_name  = "rg-demo-dev-we-iac"
  storage_account_name = "stdemodevwetfstate"
  container_name       = "tfstate"
  key                  = "demo.terraform.tfstate"
}
```

2. Migrate state:
```powershell
terraform init -migrate-state
```

## Network Configuration Details

### Address Space Allocation

| VNet | Address Space | Purpose |
|------|---------------|---------|
| Hub | 10.0.0.0/16 | Central services |
| APIM | 10.1.0.0/24 | API Management |
| Management | 10.2.0.0/24 | Management VMs |
| Spoke 01 | 10.3.0.0/24 | Workload 1 |
| Spoke 02 | 10.4.0.0/24 | Workload 2 (Function App, SQL) |
| IaC | 10.5.0.0/24 | Infrastructure as Code |
| DNS | 10.6.0.0/24 | DNS services |

### Traffic Flow
1. User → Application Gateway (Public IP)
2. Application Gateway → Azure Firewall (inspection)
3. Azure Firewall → API Management (spoke)
4. API Management → Function App (spoke)
5. Function App → SQL Database (private endpoint)

## Security Considerations

### Network Security
- All spoke VNets route traffic through Azure Firewall
- Private endpoints used for PaaS services
- No public access to databases and storage
- Azure Bastion for secure VM access

### Identity & Access
- Managed identities recommended for service-to-service authentication
- RBAC configured at resource group level
- Least privilege principle applied

### Monitoring & Compliance
- Centralized logging to Log Analytics
- Azure Monitor for alerts and metrics
- Diagnostic settings enabled on all resources

## Troubleshooting

### Common Issues

#### 1. API Management Deployment Timeout
API Management can take 30-45 minutes. If timeout occurs:
```powershell
# Check deployment status
az apim show --name apim-demo-dev-we --resource-group rg-demo-dev-we-apim
```

#### 2. VNet Peering Conflicts
Ensure no overlapping address spaces between VNets

#### 3. Private Endpoint DNS Resolution
Verify Private DNS Zone links to VNets:
```powershell
az network private-dns link vnet list \
  --resource-group rg-demo-dev-we-dns \
  --zone-name privatelink.database.windows.net
```

### Getting Help
- Review Terraform logs: `TF_LOG=DEBUG terraform apply`
- Check Azure activity logs in Azure Portal
- Review module documentation in individual module directories

## Cleanup

To destroy all resources:
```powershell
terraform destroy
```

⚠️ **Warning**: This will delete all resources. Ensure you have backups of any important data.

## Next Steps

1. **Configure Firewall Rules**: Define application and network rules
2. **Deploy Applications**: Deploy your workloads to spoke VNets
3. **Set Up Monitoring**: Configure alerts and dashboards
4. **Implement CI/CD**: Automate deployments using GitHub Actions (see CI/CD directory)
5. **Security Hardening**: Implement Azure Policy and Security Center recommendations

## Additional Resources

- [Azure Landing Zones Documentation](https://learn.microsoft.com/azure/cloud-adoption-framework/ready/landing-zone/)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)
