variable "sql_server_name" {
  description = "The name of the SQL Server."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the SQL Server will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the SQL Server will be created."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login for the SQL Server."
  type        = string
}

variable "administrator_login_password" {
  description = "The password for the administrator login."
  type        = string
  sensitive   = true
}
