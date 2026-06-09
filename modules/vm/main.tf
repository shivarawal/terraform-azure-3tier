variable "subnet_id" {
  type = string
}

resource "azurerm_network_interface" "web" {
    name                = "${var.resource_group_name}-web-nic"
	location            = var.location
	resource_group_name = var.resource_group_name

	ip_configuration {
		name                          = "ipconfig-web"
		subnet_id                     = var.subnet_id
		private_ip_address_allocation = "Dynamic"
	}
}
resource "azurerm_network_interface" "app" {
    name                = "${var.resource_group_name}-app-nic"
    location            = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "ipconfig-app"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}
resource "azurerm_network_interface" "database" {
    name                = "${var.resource_group_name}-database-nic"
    location            = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "ipconfig-database"
        subnet_id                     = var.subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_linux_virtual_machine" "web" {
  name                = "web-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D2s_v3"

  admin_username = "azureuser"

  disable_password_authentication = false
  admin_password                  = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.web.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

# resource "azurerm_linux_virtual_machine" "app" {
#   name                = "app-vm"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   size                = "Standard_D1_v2"

#   admin_username = "azureuser"

#   disable_password_authentication = false
#   admin_password                  = var.admin_password

#   network_interface_ids = [
#     azurerm_network_interface.app.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }

# resource "azurerm_linux_virtual_machine" "database" {
#   name                = "database-vm"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   size                = "Standard DSv2"

#   admin_username = "azureuser"

#   disable_password_authentication = false
#  admin_password = var.admin_password

#   network_interface_ids = [
#     azurerm_network_interface.database.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }