# Terraform configuration for Contoso Ltd - Dev Environment
# This file configures the Terraform settings and providers

terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }

  # Uncomment and configure backend for remote state management
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "stterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "contoso-dev.terraform.tfstate"
  # }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Data source for current client configuration
data "azurerm_client_config" "current" {}

# Random ID for unique naming
resource "random_id" "unique" {
  byte_length = 2
}

# Local values for common tags and naming
locals {
  common_tags = {
    Environment   = var.environment
    Project       = var.project_name
    DeployedBy    = "Terraform"
    DeployedDate  = timestamp()
    Owner         = var.owner
  }

  location_short = var.location_short_names[var.location]
  name_suffix    = format("%03d", random_id.unique.dec)
}