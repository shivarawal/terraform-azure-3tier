variable "resource_group_name" {
  description = "Name of the resource group to deploy the security resources into."
  type        = string
}
variable "location" {
  description = "Azure region where the security resources will be deployed."
  type        = string
}
variable "web_subnet_id" {
  description = "ID of the subnet where the web application is hosted."
  type        = string
}
variable "app_subnet_id" {
  description = "ID of the subnet where the application is hosted."
  type        = string
}
variable "database_subnet_id" {
  description = "ID of the subnet where the database is hosted."
  type        = string
}