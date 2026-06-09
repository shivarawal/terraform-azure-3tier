variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the resources."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network to create."
  type        = string
}

variable "web_subnet_name" {
  description = "The name of the Web Subnet."
  type        = string
}

variable "app_subnet_name" {
  description = "The name of the Application Subnet."
  type        = string
}

variable "database_subnet_name" {
  description = "The name of the Database Subnet."
  type        = string
}
variable "load_balancer_name" {
  description = "Name of the Load Balancer"
  type        = string
}
variable "admin_password" {
  description = "VM Administrator Password"
  type        = string
  sensitive   = true
}