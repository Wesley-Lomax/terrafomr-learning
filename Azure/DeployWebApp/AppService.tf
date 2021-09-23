/* 
Deploy a Standard tier, "S1" application service plan with a Dot Net 4.0 framework with a local git software config manager. 
As in previous labs, be sure to copy in the lab generated resource group name.
https://app.linuxacademy.com/hands-on-labs/343bd2cd-152c-4d93-8638-141efad836dd
  */

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {  
  features {}
  
  /* 
  subscription_id   = "<azure_subscription_id>"
  tenant_id         = "<azure_subscription_tenant_id>"
  client_id         = "<service_principal_appid>"
  client_secret     = "<service_principal_password>" 
  */
}

resource "azurerm_resource_group" "test_rg" {
  name     = "rg-test-resources"
  location = "UK South"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "wl-test-deploy-hp"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name

  sku {
    tier = "Standard"
    size = "S1"
    capacity = "2"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "wl-test-deploy-app"
  location            = azurerm_resource_group.test_rg.location
  resource_group_name = azurerm_resource_group.test_rg.name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
