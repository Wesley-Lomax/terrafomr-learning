/* 
Deploy a Standard tier, "S1" application service plan with a Dot Net 4.0 framework with a local git software config manager. 
As in previous labs, be sure to copy in the lab generated resource group name.
https://app.linuxacademy.com/hands-on-labs/343bd2cd-152c-4d93-8638-141efad836dd
  */

provider "azurerm" {
  version = 1.38
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "wesley-testing-terraform-hp"
  location            = "eastus"
  resource_group_name = "191-0aa601a8-deploy-a-web-application-with-terrafo"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "wesley-testing-terraform-app"
  location            = "eastus"
  resource_group_name = "191-0aa601a8-deploy-a-web-application-with-terrafo"
  app_service_plan_id = azurerm_app_service_plan.svcplan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
