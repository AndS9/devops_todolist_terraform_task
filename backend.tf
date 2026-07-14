terraform {
  backend "azurerm" {
    storage_account_name = "yourstorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    resource_group_name  = "mate-azure-task-12"
    use_oidc             = true
  }
}
