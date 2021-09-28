provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test_rg" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
}

resource "azurerm_sql_server" "wl-test-sql" {
  name                         = "${var.prefix}-sqlsvr"
  resource_group_name          = "${azurerm_resource_group.test_rg.name}"
  location                     = "${azurerm_resource_group.test_rg.location}"
  version                      = "12.0"
  administrator_login          = "${var.administrator_login}"
  administrator_login_password = "${var.administrator_password}"
}

resource "azurerm_sql_database" "wl-test-db" {
  name                             = "${var.prefix}-db"
  resource_group_name              = "${azurerm_resource_group.test_rg.name}"
  location                         = "${azurerm_resource_group.test_rg.location}"
  server_name                      = "${azurerm_sql_server.wl-test-sql.name}"
  edition                          = "Basic"
  collation                        = "SQL_Latin1_General_CP1_CI_AS"
  create_mode                      = "Default"
  requested_service_objective_name = "Basic"
}

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource "azurerm_sql_firewall_rule" "example" {
  name                = "allow-azure-services"
  resource_group_name = "${azurerm_resource_group.test_rg.name}"
  server_name         = "${azurerm_sql_server.wl-test-sql.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}