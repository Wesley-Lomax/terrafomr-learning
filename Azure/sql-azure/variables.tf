variable "prefix" {
  description = "The prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "administrator_login" {
  description = "SQL Administrator Login"  
}

variable "administrator_password" {
  description = "SQL Administrator Password"
  sensitive = true
}