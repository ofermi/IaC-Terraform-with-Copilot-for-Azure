variable "name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username"
  type        = string
}

variable "os_type" {
  description = "OS type (Windows or Linux)"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}

variable "tags" {
  description = "Tags for the resource"
  type        = map(string)
}
