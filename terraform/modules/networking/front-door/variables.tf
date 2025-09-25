variable "front_door_name" {
  description = "Name of the Front Door profile"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "front_door_sku" {
  description = "Front Door SKU"
  type        = string
  default     = "Standard_AzureFrontDoor"
  
  validation {
    condition     = contains(["Standard_AzureFrontDoor", "Premium_AzureFrontDoor"], var.front_door_sku)
    error_message = "SKU must be Standard_AzureFrontDoor or Premium_AzureFrontDoor."
  }
}

variable "health_probe_path" {
  description = "Health probe path"
  type        = string
  default     = "/"
}

variable "backend_origins" {
  description = "Backend origins configuration"
  type = list(object({
    host_name                  = string
    priority                   = number
    weight                     = number
    private_link_target_type   = optional(string, "sites")
    private_link_target_id     = optional(string, null)
  }))
  default = []
}

variable "custom_domain_ids" {
  description = "List of custom domain IDs"
  type        = list(string)
  default     = []
}

variable "cache_query_strings" {
  description = "Query strings to ignore in caching"
  type        = list(string)
  default     = ["utm_campaign", "utm_source", "utm_medium"]
}

variable "content_types_to_compress" {
  description = "Content types to compress"
  type        = list(string)
  default = [
    "application/eot",
    "application/font",
    "application/font-sfnt",
    "application/javascript",
    "application/json",
    "application/opentype",
    "application/otf",
    "application/pkcs7-mime",
    "application/truetype",
    "application/ttf",
    "application/vnd.ms-fontobject",
    "application/xhtml+xml",
    "application/xml",
    "application/xml+rss",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/x-httpd-cgi",
    "application/x-javascript",
    "application/x-mpegurl",
    "application/x-opentype",
    "application/x-otf",
    "application/x-perl",
    "application/x-ttf",
    "font/eot",
    "font/ttf",
    "font/otf",
    "font/opentype",
    "image/svg+xml",
    "text/css",
    "text/csv",
    "text/html",
    "text/javascript",
    "text/js",
    "text/plain",
    "text/richtext",
    "text/tab-separated-values",
    "text/xml",
    "text/x-script",
    "text/x-component",
    "text/x-java-source"
  ]
}

variable "enable_waf" {
  description = "Enable Web Application Firewall"
  type        = bool
  default     = true
}

variable "waf_mode" {
  description = "WAF mode - Detection or Prevention"
  type        = string
  default     = "Prevention"
  
  validation {
    condition     = contains(["Detection", "Prevention"], var.waf_mode)
    error_message = "WAF mode must be Detection or Prevention."
  }
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}