# Quick Reference Guide

## 🚀 Quick Start Commands

### Initial Setup
```powershell
# Set environment variables
$env:TF_VAR_subscription_id = "your-subscription-id"
$env:TF_VAR_vm_admin_password = "YourSecurePassword123!"
$env:TF_VAR_sql_admin_password = "YourSecurePassword123!"

# Navigate to environment
cd terraform/environments/dev

# Initialize Terraform
terraform init
```

### Deploy
```powershell
# Plan
terraform plan -out=tfplan

# Apply
terraform apply tfplan

# Auto-approve (use with caution)
terraform apply -auto-approve
```

### Destroy
```powershell
# Destroy specific resource
terraform destroy -target=module.bastion

# Destroy everything
terraform destroy
```

## 📋 Common Tasks

### View Outputs
```powershell
terraform output
terraform output resource_group_names
terraform output vnet_ids
```

### Validate Configuration
```powershell
terraform validate
terraform fmt -check
```

### Check State
```powershell
terraform show
terraform state list
terraform state show module.rg_hub[0].azurerm_resource_group.rg
```

### Refresh State
```powershell
terraform refresh
```

## 🔧 Customization

### Toggle Resources
Edit `terraform.tfvars`:
```hcl
create_bastion              = false  # Disable Bastion
create_application_gateway  = false  # Disable App Gateway
create_api_management       = false  # Disable APIM
```

### Change Network Ranges
Edit `terraform.tfvars`:
```hcl
hub_vnet_address_space = ["10.100.0.0/16"]
spoke01_vnet_address_space = ["10.110.0.0/23"]
```

### Modify SKUs
Edit `terraform.tfvars`:
```hcl
vm_size = "Standard_B2s"  # Cheaper VM
sql_sku_name = "Basic"    # Cheaper SQL
```

## 📍 File Locations

| File | Path |
|------|------|
| Main config | `terraform/environments/dev/main.tf` |
| Variables | `terraform/environments/dev/variables.tf` |
| Values | `terraform/environments/dev/terraform.tfvars` |
| Resources | `terraform/environments/dev/resources.tf` |
| Naming | `terraform/environments/dev/locals.tf` |
| Outputs | `terraform/environments/dev/outputs.tf` |

## 🔑 Required Secrets

### Environment Variables
- `TF_VAR_subscription_id`
- `TF_VAR_vm_admin_password`
- `TF_VAR_sql_admin_password`

### GitHub Secrets (for CI/CD)
- `AZURE_CREDENTIALS`
- `ARM_CLIENT_ID`
- `ARM_CLIENT_SECRET`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`
- `VM_ADMIN_PASSWORD`
- `SQL_ADMIN_PASSWORD`

## 🌐 Resource Access

### After Deployment

**Azure Portal**: https://portal.azure.com

**Resource Groups**:
- `rg-hubspoke-dev-eus-hub-001`
- `rg-hubspoke-dev-eus-apm-001`
- `rg-hubspoke-dev-eus-mgmt-001`
- `rg-hubspoke-dev-eus-spoke01-001`
- `rg-hubspoke-dev-eus-spoke02-001`
- `rg-hubspoke-dev-eus-iac-001`
- `rg-hubspoke-dev-eus-dns-001`
- `rg-hubspoke-dev-eus-governance-001`

### Connect to VMs

Use Azure Bastion from the portal:
1. Navigate to VM in portal
2. Click "Connect" → "Bastion"
3. Enter credentials
4. Connect via browser

## 🐛 Troubleshooting

### Authentication Error
```powershell
az login
az account set --subscription "subscription-id"
```

### Backend Error
Comment out backend block in `main.tf` temporarily:
```hcl
# backend "azurerm" {
#   ...
# }
```

### Name Conflict
Update serial number in `locals.tf`:
```hcl
resource_group_naming = {
  hub = "rg-${var.project}-${var.environment}-${var.location_short}-hub-002"
}
```

### Quota Exceeded
```powershell
# Check quotas
az vm list-usage --location eastus -o table

# Request increase via portal
```

## 📊 Cost Management

### View Estimated Costs
Use Azure Pricing Calculator:
https://azure.microsoft.com/pricing/calculator/

### Tag Resources for Cost Tracking
Already configured in `locals.tf`:
```hcl
tags = {
  Environment = "dev"
  ManagedBy   = "Terraform"
  Project     = "HubSpoke"
  CostCenter  = "IT"
}
```

### Reduce Costs
1. Deallocate VMs when not needed
2. Use smaller SKUs for dev/test
3. Set auto-shutdown schedules
4. Review unused resources

## 🔒 Security Checklist

- [ ] Update subscription ID in `terraform.tfvars`
- [ ] Set strong passwords via environment variables
- [ ] Never commit `.tfvars` files with secrets
- [ ] Enable Azure Security Center
- [ ] Review NSG rules
- [ ] Configure Azure Firewall (if needed)
- [ ] Set up Azure Key Vault for secrets
- [ ] Enable diagnostic logging
- [ ] Configure alerts

## 📞 Useful Links

- **Azure Portal**: https://portal.azure.com
- **Terraform Docs**: https://www.terraform.io/docs
- **Azure Docs**: https://docs.microsoft.com/azure
- **AVM Registry**: https://azure.github.io/Azure-Verified-Modules/
- **Terraform Registry**: https://registry.terraform.io

## 🎯 Next Steps Checklist

After successful deployment:

- [ ] Verify all resource groups created
- [ ] Test VNet connectivity
- [ ] Configure NSG rules
- [ ] Deploy applications to spoke VNets
- [ ] Configure Application Gateway backends
- [ ] Import APIs to API Management
- [ ] Set up monitoring alerts
- [ ] Configure backup policies
- [ ] Document custom configurations
- [ ] Set up CI/CD for applications

---

**Keep this guide handy for quick reference!**
