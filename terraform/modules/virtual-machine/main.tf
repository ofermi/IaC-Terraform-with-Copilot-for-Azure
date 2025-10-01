# ==============================================================================
# Virtual Machine Module
# Using Azure Verified Modules (AVM)
# ==============================================================================

resource "azurerm_network_interface" "nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

module "avm_virtual_machine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.17.0"

  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  zone                = null  # No availability zone
  
  os_type  = "Windows"
  sku_size = var.size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interfaces = {
    network_interface_0 = {
      name                 = azurerm_network_interface.nic.name
      network_interface_id = azurerm_network_interface.nic.id
      ip_configurations = {
        ip_configuration_0 = {
          name                          = "internal"
          private_ip_address_allocation = "Dynamic"
        }
      }
    }
  }

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  tags = var.tags
}
