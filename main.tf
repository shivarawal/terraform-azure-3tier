
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_subnet" "database" {
  name                 = var.database_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.3.0/24"]
}
module "security" {
  source              = "./modules/security"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  web_subnet_id       = azurerm_subnet.web.id
  app_subnet_id       = azurerm_subnet.app.id
  database_subnet_id  = azurerm_subnet.database.id
}
module "loadbalancer" {
  source              = "./modules/loadbalancer"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  load_balancer_name  = var.load_balancer_name
}
module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  web_subnet_name     = azurerm_subnet.web.name
  app_subnet_name     = azurerm_subnet.app.name
  subnet_id           = azurerm_subnet.web.id

  admin_password = var.admin_password
}

# module "network" {
#   source                = "./modules/network"
#   resource_group_name   = azurerm_resource_group.main.name
#   location              = azurerm_resource_group.main.location
#   nsg_name              = "web-nsg"
#   vnet_name             = azurerm_virtual_network.main.name
#   vnet_address_space    = ["10.0.0.0/16"]
#   subnet_name           = var.web_subnet_name
#   subnet_address_prefix = "10.0.1.0/24"
# }