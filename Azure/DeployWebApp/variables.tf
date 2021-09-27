variable "prefix" {
  description = "The prefix used for all resources in this example"
}

variable "location" {
  description = "The Azure location where all resources in this example should be created"
}

variable "hosting_plan_sku_tier" {
  description = "The App Service Plan sku tier"
}

variable "hosting_plan_sku_size" {
  description = "The App Service Plan sku size"
}

variable "hosting_plan_sku_capacity" {
  description = "The App Service Plan sku capacity"
}