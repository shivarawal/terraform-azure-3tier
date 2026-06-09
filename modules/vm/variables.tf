variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}
variable "location" {
    description = "Azure region for the resources"
    type        = string
}
variable "app_subnet_name" {
    description = "Name of the application subnet"
    type        = string
}
variable "web_subnet_name" {
    description = "Name of the web subnet"
    type        = string
}
variable "admin_password" {
  description = "Password for VM admin user"
  type        = string
  sensitive   = true
}