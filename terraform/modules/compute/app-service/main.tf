# App Service Module
# Uses Azure Verified Module for App Service

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# App Service using AVM
module "app_service" {
  source  = "Azure/avm-res-web-site/azurerm"
  version = "~> 0.10.0"

  enable_telemetry         = var.enable_telemetry
  location                 = var.location
  name                     = var.app_service_name
  resource_group_name      = var.resource_group_name
  service_plan_resource_id = var.service_plan_id
  kind                     = "app"
  os_type                  = "Linux"

  # App settings
  site_config = {
    minimum_tls_version = "1.2"
    http2_enabled      = true
    always_on          = var.always_on
  }

  # Application settings
  app_settings = var.app_settings

  tags = var.tags
}