# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTestAzureGroup"
  location = "eastus"
  tags = {
    creator = "kasun amarasinghe"
  }
}

# create SQL sever in azure
resource "azurerm_sql_server" "server" {
  name                         = "my-test-sqlserver"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = "eastus"
  version                      = "12.0"
  administrator_login          = var.database_username
  administrator_login_password = var.database_password

  tags = {
    environment = "production"
    creator     = "kasun amarasinghe"
  }
}

resource "azurerm_sql_database" "db" {
  name                = "my-test-sql-database"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "eastus"
  server_name         = azurerm_sql_server.server.name

  tags = {
    environment = "production"
    creator     = "kasun amarasinghe"
  }
}
