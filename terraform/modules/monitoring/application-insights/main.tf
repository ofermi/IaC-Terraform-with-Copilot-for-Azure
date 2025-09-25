# Application Insights Module

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Application Insights resource
resource "azurerm_application_insights" "main" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  application_type    = var.application_type
  
  # Configuration
  retention_in_days                 = var.retention_in_days
  daily_data_cap_in_gb             = var.daily_data_cap_in_gb
  daily_data_cap_notifications_disabled = var.daily_data_cap_notifications_disabled
  sampling_percentage              = var.sampling_percentage
  disable_ip_masking              = var.disable_ip_masking
  
  # Internet configuration
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled
  
  # Force customer storage for profiler and snapshot debugger
  force_customer_storage_for_profiler = var.force_customer_storage_for_profiler

  tags = var.tags
}