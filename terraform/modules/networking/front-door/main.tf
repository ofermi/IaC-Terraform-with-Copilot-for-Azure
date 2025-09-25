# Azure Front Door Module
# Uses Azure Verified Module for Front Door

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure Front Door Profile
resource "azurerm_cdn_frontdoor_profile" "front_door" {
  name                = var.front_door_name
  resource_group_name = var.resource_group_name
  sku_name           = var.front_door_sku

  tags = var.tags
}

# Front Door Endpoint
resource "azurerm_cdn_frontdoor_endpoint" "front_door_endpoint" {
  name                     = "${var.front_door_name}-endpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.front_door.id
  enabled                  = true

  tags = var.tags
}

# Origin Group
resource "azurerm_cdn_frontdoor_origin_group" "app_origin_group" {
  name                     = "${var.front_door_name}-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.front_door.id
  session_affinity_enabled = false

  load_balancing {
    sample_size                        = 4
    successful_samples_required        = 3
    additional_latency_in_milliseconds = 50
  }

  health_probe {
    interval_in_seconds = 240
    path                = var.health_probe_path
    protocol            = "Https"
    request_type        = "HEAD"
  }
}

# Origins
resource "azurerm_cdn_frontdoor_origin" "app_service_origin" {
  count                          = length(var.backend_origins)
  name                          = "${var.front_door_name}-origin-${count.index}"
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.app_origin_group.id
  enabled                       = true

  certificate_name_check_enabled = true
  host_name                     = var.backend_origins[count.index].host_name
  http_port                     = 80
  https_port                    = 443
  origin_host_header           = var.backend_origins[count.index].host_name
  priority                     = var.backend_origins[count.index].priority
  weight                       = var.backend_origins[count.index].weight

  private_link {
    request_message        = "Private Link connection from Front Door"
    target_type           = var.backend_origins[count.index].private_link_target_type
    location              = var.location
    private_link_target_id = var.backend_origins[count.index].private_link_target_id
  }
}

# Route
resource "azurerm_cdn_frontdoor_route" "front_door_route" {
  name                          = "${var.front_door_name}-route"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.front_door_endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.app_origin_group.id
  cdn_frontdoor_origin_ids      = azurerm_cdn_frontdoor_origin.app_service_origin[*].id
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = var.custom_domain_ids
  link_to_default_domain         = true

  cache {
    query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
    query_strings                 = var.cache_query_strings
    compression_enabled           = true
    content_types_to_compress     = var.content_types_to_compress
  }
}

# WAF Policy (Optional)
resource "azurerm_cdn_frontdoor_firewall_policy" "waf_policy" {
  count               = var.enable_waf ? 1 : 0
  name                = replace("${var.front_door_name}wafpolicy", "-", "")
  resource_group_name = var.resource_group_name
  sku_name           = azurerm_cdn_frontdoor_profile.front_door.sku_name
  enabled            = true
  mode               = var.waf_mode

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action  = "Block"
  }

  managed_rule {
    type    = "BotProtection"
    version = "preview-0.1"
    action  = "Block"
  }

  tags = var.tags
}

# Security Policy (Link WAF to Front Door)
resource "azurerm_cdn_frontdoor_security_policy" "security_policy" {
  count                    = var.enable_waf ? 1 : 0
  name                     = "${var.front_door_name}-security-policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.front_door.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.waf_policy[0].id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_endpoint.front_door_endpoint.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}