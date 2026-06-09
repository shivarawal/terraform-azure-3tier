variable "load_balancer_name" {
  description = "Name of the load balancer to be created."
  type        = string
  
}
variable "resource_group_name" {
  description = "Name of the resource group to deploy the load balancer into."
  type        = string
}
variable "location" {
  description = "Azure region where the load balancer will be deployed."
  type        = string
}