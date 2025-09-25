# Container Instances Module Variables

variable "location" {
  description = "Azure region where the Container Group will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "container_group_name" {
  description = "Name of the Container Group"
  type        = string
}

variable "os_type" {
  description = "Operating system type (Linux or Windows)"
  type        = string
  default     = "Linux"
  
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be Linux or Windows."
  }
}

variable "restart_policy" {
  description = "Restart policy for containers"
  type        = string
  default     = "Always"
  
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "Restart policy must be Always, Never, or OnFailure."
  }
}

variable "ip_address_type" {
  description = "IP address type (Public, Private, or None)"
  type        = string
  default     = "Public"
  
  validation {
    condition     = contains(["Public", "Private", "None"], var.ip_address_type)
    error_message = "IP address type must be Public, Private, or None."
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs for private IP addresses"
  type        = list(string)
  default     = []
}

variable "dns_config" {
  description = "DNS configuration for the container group"
  type = object({
    nameservers    = list(string)
    search_domains = optional(list(string))
    options        = optional(list(string))
  })
  default = null
}

variable "identity" {
  description = "Identity configuration for the container group"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "containers" {
  description = "List of containers in the group"
  type = list(object({
    name   = string
    image  = string
    cpu    = number
    memory = number
    
    ports = list(object({
      port     = number
      protocol = string
    }))
    
    environment_variables        = optional(map(string))
    secure_environment_variables = optional(map(string))
    commands                    = optional(list(string))
    
    volumes = optional(list(object({
      name                 = string
      mount_path          = string
      read_only           = optional(bool)
      empty_dir           = optional(bool)
      storage_account_name = optional(string)
      storage_account_key  = optional(string)
      share_name          = optional(string)
    })))
    
    liveness_probe = optional(object({
      exec                  = optional(list(string))
      initial_delay_seconds = optional(number)
      period_seconds       = optional(number)
      failure_threshold    = optional(number)
      success_threshold    = optional(number)
      timeout_seconds      = optional(number)
      http_get = optional(object({
        path   = string
        port   = number
        scheme = optional(string)
      }))
    }))
    
    readiness_probe = optional(object({
      exec                  = optional(list(string))
      initial_delay_seconds = optional(number)
      period_seconds       = optional(number)
      failure_threshold    = optional(number)
      success_threshold    = optional(number)
      timeout_seconds      = optional(number)
      http_get = optional(object({
        path   = string
        port   = number
        scheme = optional(string)
      }))
    }))
  }))
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}