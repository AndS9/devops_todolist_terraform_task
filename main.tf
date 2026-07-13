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
}
resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}
module "network" {
  source                  = "./modules/network"
  prefix                  = var.prefix
  resource_group_name     = var.resource_group_name
  resource_group_location = var.location
  network_name            = var.virtual_network_name
  v_net_address_prefix    = var.vnet_address_prefix
  subnet_name             = var.subnet_name
  subnet_address_prefix   = var.subnet_address_prefix
  pip_name                = var.public_ip_address_name
  dns_label               = "${var.dns_label}-${random_string.suffix.result}"
  network_SG_name         = var.network_security_group_name
  security_rules          = var.security_rules
}