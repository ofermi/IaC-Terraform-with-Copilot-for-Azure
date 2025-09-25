# Virtual Machine Module
# Uses standard Terraform azurerm provider (AVM not yet available for all VM configurations)

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Network Interface for VM
resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.os_type == "Linux" ? 1 : 0
  name                           = var.vm_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  size                           = var.vm_size
  admin_username                 = var.admin_username
  disable_password_authentication = true
  zone                           = var.zone

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key != null ? var.ssh_public_key : tls_private_key.vm_ssh[0].public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  tags = var.tags
}

# Windows VM
resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password != null ? var.admin_password : random_password.vm_password[0].result
  zone                = var.zone

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  tags = var.tags
}

# Generate SSH key for Linux VMs if not provided
resource "tls_private_key" "vm_ssh" {
  count     = var.os_type == "Linux" && var.ssh_public_key == null ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate password for Windows VMs if not provided
resource "random_password" "vm_password" {
  count   = var.os_type == "Windows" && var.admin_password == null ? 1 : 0
  length  = 16
  special = true
}