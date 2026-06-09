resource "azurerm_public_ip" "main" {
  name                = "lb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}
resource "azurerm_lb" "main" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}
resource "azurerm_lb_backend_address_pool" "main" {
  name            = "main-backend-pool"
  loadbalancer_id = azurerm_lb.main.id
}
resource "azurerm_lb_probe" "main" {
  name                = "main-health-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Tcp"
  port                = 80
}
resource "azurerm_lb_rule" "main" {
  name                           = "main-lb-rule"
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
  probe_id                       = azurerm_lb_probe.main.id
}
