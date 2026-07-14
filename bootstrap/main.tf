terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
module "backend_storage" {
  source                  = "../modules/storage"
  resource_group_name     = azurerm_resource_group.example.name
  resource_group_location = azurerm_resource_group.example.location
  storage_account_name    = "ands9storageaccount"
  container_name          = "tfstate"
}