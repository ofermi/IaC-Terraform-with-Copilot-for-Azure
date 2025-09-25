# Container Instances Module

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Container Group
resource "azurerm_container_group" "main" {
  name                = var.container_group_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  restart_policy      = var.restart_policy
  ip_address_type     = var.ip_address_type
  subnet_ids          = var.subnet_ids

  # DNS configuration
  dynamic "dns_config" {
    for_each = var.dns_config != null ? [var.dns_config] : []
    content {
      nameservers    = dns_config.value.nameservers
      search_domains = dns_config.value.search_domains
      options        = dns_config.value.options
    }
  }

  # Identity configuration
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  # Container configuration
  dynamic "container" {
    for_each = var.containers
    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      # Ports
      dynamic "ports" {
        for_each = container.value.ports
        content {
          port     = ports.value.port
          protocol = ports.value.protocol
        }
      }

      # Environment variables
      dynamic "environment_variables" {
        for_each = container.value.environment_variables != null ? container.value.environment_variables : {}
        content {
          name  = environment_variables.key
          value = environment_variables.value
        }
      }

      # Secure environment variables
      dynamic "secure_environment_variables" {
        for_each = container.value.secure_environment_variables != null ? container.value.secure_environment_variables : {}
        content {
          name  = secure_environment_variables.key
          value = secure_environment_variables.value
        }
      }

      # Volume mounts
      dynamic "volume" {
        for_each = container.value.volumes != null ? container.value.volumes : []
        content {
          name                 = volume.value.name
          mount_path           = volume.value.mount_path
          read_only           = volume.value.read_only
          empty_dir           = volume.value.empty_dir
          storage_account_name = volume.value.storage_account_name
          storage_account_key  = volume.value.storage_account_key
          share_name          = volume.value.share_name
        }
      }

      # Commands
      commands = container.value.commands

      # Liveness probe
      dynamic "liveness_probe" {
        for_each = container.value.liveness_probe != null ? [container.value.liveness_probe] : []
        content {
          exec                  = liveness_probe.value.exec
          initial_delay_seconds = liveness_probe.value.initial_delay_seconds
          period_seconds       = liveness_probe.value.period_seconds
          failure_threshold    = liveness_probe.value.failure_threshold
          success_threshold    = liveness_probe.value.success_threshold
          timeout_seconds      = liveness_probe.value.timeout_seconds

          dynamic "http_get" {
            for_each = liveness_probe.value.http_get != null ? [liveness_probe.value.http_get] : []
            content {
              path   = http_get.value.path
              port   = http_get.value.port
              scheme = http_get.value.scheme
            }
          }
        }
      }

      # Readiness probe
      dynamic "readiness_probe" {
        for_each = container.value.readiness_probe != null ? [container.value.readiness_probe] : []
        content {
          exec                  = readiness_probe.value.exec
          initial_delay_seconds = readiness_probe.value.initial_delay_seconds
          period_seconds       = readiness_probe.value.period_seconds
          failure_threshold    = readiness_probe.value.failure_threshold
          success_threshold    = readiness_probe.value.success_threshold
          timeout_seconds      = readiness_probe.value.timeout_seconds

          dynamic "http_get" {
            for_each = readiness_probe.value.http_get != null ? [readiness_probe.value.http_get] : []
            content {
              path   = http_get.value.path
              port   = http_get.value.port
              scheme = http_get.value.scheme
            }
          }
        }
      }
    }
  }

  tags = var.tags
}