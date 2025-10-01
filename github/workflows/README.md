# GitHub Actions CI/CD Pipeline for Terraform

## Overview
This directory contains GitHub Actions workflows for automating Terraform deployments to Azure.

## Workflows

### terraform-cicd.yml
Complete CI/CD pipeline with the following jobs:

#### 1. Terraform Validate
- **Trigger**: All pushes and PRs
- **Actions**:
  - Checks Terraform formatting
  - Initializes Terraform (no backend)
  - Validates configuration syntax

#### 2. Terraform Plan
- **Trigger**: Pull requests only
- **Actions**:
  - Authenticates to Azure
  - Runs `terraform plan`
  - Posts plan results as PR comment
  - Fails if plan has errors

#### 3. Terraform Apply
- **Trigger**: Push to main branch only
- **Environment**: Production (requires approval)
- **Actions**:
  - Authenticates to Azure
  - Runs `terraform plan`
  - Applies changes automatically
  - Outputs deployment results

#### 4. Security Scan
- **Trigger**: All pushes and PRs
- **Actions**:
  - Runs Checkov security scanning
  - Uploads results to GitHub Security tab
  - Soft fail mode (doesn't block deployment)

## Prerequisites

### 1. Azure Service Principal
Create a service principal with Contributor access:

```powershell
# Create service principal
$sp = az ad sp create-for-rbac --name "sp-terraform-github" `
  --role Contributor `
  --scopes /subscriptions/<subscription-id> `
  --sdk-auth

# The output will contain:
# - clientId
# - clientSecret
# - subscriptionId
# - tenantId
```

### 2. Configure Federated Credentials (Recommended)
For enhanced security, use workload identity federation:

```powershell
az ad app federated-credential create `
  --id <application-id> `
  --parameters @credential.json
```

credential.json:
```json
{
  "name": "github-federation",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:<org>/<repo>:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}
```

### 3. GitHub Secrets
Add the following secrets to your repository:
- `AZURE_CLIENT_ID`: Service principal client ID
- `AZURE_TENANT_ID`: Azure AD tenant ID
- `AZURE_SUBSCRIPTION_ID`: Azure subscription ID
- `AZURE_CLIENT_SECRET`: Service principal secret (if not using federation)

#### Setting Secrets
1. Go to repository → Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add each secret listed above

### 4. GitHub Environment
Create a production environment for approval gates:

1. Go to repository → Settings → Environments
2. Click "New environment"
3. Name it "production"
4. Add required reviewers (recommended)
5. Add deployment protection rules if needed

## Usage

### Pull Request Workflow
1. Create a feature branch
2. Make Terraform changes
3. Push branch and create PR
4. Workflow runs automatically:
   - Validates Terraform
   - Runs plan
   - Posts plan results to PR
5. Review plan in PR comment
6. Merge PR after approval

### Deployment Workflow
1. Merge PR to main branch
2. Workflow runs automatically:
   - Validates Terraform
   - Runs plan
   - Waits for production environment approval
   - Applies changes
3. Monitor deployment in Actions tab

### Manual Trigger
Trigger workflow manually:
1. Go to Actions tab
2. Select "Terraform CI/CD" workflow
3. Click "Run workflow"
4. Select branch
5. Click "Run workflow"

## Customization

### Change Working Directory
Edit `WORKING_DIR` in workflow:
```yaml
env:
  WORKING_DIR: './terraform/environments/prod'
```

### Add Environments
Duplicate workflow for multiple environments:
```yaml
strategy:
  matrix:
    environment: [dev, staging, prod]
env:
  WORKING_DIR: './terraform/environments/${{ matrix.environment }}'
```

### Modify Triggers
Change when workflows run:
```yaml
on:
  push:
    branches: [main, develop]
    paths:
      - 'terraform/**'
      - '.github/workflows/**'
```

## Security Best Practices

1. **Use Federated Credentials**: Avoid storing secrets
2. **Require PR Reviews**: Enforce code review before merge
3. **Environment Protection**: Require approval for production
4. **Least Privilege**: Grant minimal Azure permissions
5. **Secret Rotation**: Rotate service principal credentials regularly
6. **Branch Protection**: Enable branch protection rules on main

## Troubleshooting

### Common Issues

#### Authentication Failure
```
Error: Error building AzureRM Client: obtain subscription
```
**Solution**: Verify service principal credentials in secrets

#### Plan Posting Failure
```
Error: Comment body cannot exceed 65536 characters
```
**Solution**: Plan output too large, consider using artifacts instead

#### Apply Timeout
```
Error: context deadline exceeded
```
**Solution**: Increase workflow timeout:
```yaml
jobs:
  terraform-apply:
    timeout-minutes: 90
```

### Debugging
Enable debug logging:
1. Go to repository Settings → Secrets
2. Add secret: `ACTIONS_RUNNER_DEBUG` = `true`
3. Add secret: `ACTIONS_STEP_DEBUG` = `true`
4. Re-run workflow

## Workflow Status Badge
Add status badge to README:
```markdown
![Terraform CI/CD](https://github.com/<org>/<repo>/workflows/Terraform%20CI/CD/badge.svg)
```

## Additional Resources
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Terraform GitHub Actions](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
- [Azure Login Action](https://github.com/Azure/login)
- [Checkov GitHub Action](https://github.com/bridgecrewio/checkov-action)
