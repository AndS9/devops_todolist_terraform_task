terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.80.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
  }
}

provider "azurerm" {
  features {

  }
  use_oidc = true
}
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}
/*
I CAN"T USE IT IN MAIN, BECAUSE IT MUST BE CREATED WITH STORAGE ACC
BEFORE BACKEND for TERRAFORM TO PROPERLY START

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
*/

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}


module "network" {
  source                  = "./modules/network"
  resource_group_name     = data.azurerm_resource_group.main.name
  resource_group_location = data.azurerm_resource_group.main.location
  network_name            = var.virtual_network_name
  v_net_address_prefix    = var.vnet_address_prefix
  subnet_name             = var.subnet_name
  subnet_address_prefix   = var.subnet_address_prefix
  pip_name                = var.public_ip_address_name
  dns_label               = "${var.dns_label}-${random_string.suffix.result}"
  network_SG_name         = var.network_security_group_name
  security_rules          = var.security_rules
}
module "compute" {
  source                  = "./modules/compute"
  resource_group_name     = data.azurerm_resource_group.main.name
  resource_group_location = data.azurerm_resource_group.main.location
  vm_name                 = var.vm_name
  vm_size                 = var.vm_size
  subnet_id               = module.network.subnet_id
  public_ip_id            = module.network.public_ip_id
  NSG_id                  = module.network.NSG_id
  extension_name          = "CustomScript"
  path_to_script          = "install-app.sh"
  SSH_key                 = "linuxboxsshkey"
  ssh_public_key_content  = var.ssh_key_public
}
module "storage" {
  source                  = "./modules/storage"
  resource_group_name     = data.azurerm_resource_group.main.name
  resource_group_location = data.azurerm_resource_group.main.location
  storage_account_name    = var.storage_account_name
  container_name          = "task-artifacts"
}