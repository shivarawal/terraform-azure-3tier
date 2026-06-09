output "load_balancer_id" {
  value = azurerm_lb.main.id
}
output "load_balancer_frontend_ip_id" {
  value = azurerm_lb.main.frontend_ip_configuration[0].id
}
output "load_balancer_backend_pool_id" {
  value = azurerm_lb_backend_address_pool.main.id
}
