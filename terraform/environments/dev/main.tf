# ============================================================================
# Terraform Configuration
# ============================================================================

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Backend configuration for storing Terraform state
  # Uncomment and configure after initial deployment
  # backend "azurerm" {
  #   resource_group_name  = "rg-demo-dev-we-iac"
  #   storage_account_name = "stdemodevwetfstate"
  #   container_name       = "tfstate"
  #   key                  = "demo.terraform.tfstate"
  # }
}

# ============================================================================
# Provider Configuration
# ============================================================================

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    virtual_machine {
      delete_os_disk_on_deletion     = true
      skip_shutdown_and_force_delete = false
    }

    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }
  }
}

provider "random" {
}
