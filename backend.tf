terraform {
  backend "azurerm" {
    resource_group_name  = "tfstateN01663926RG"
    storage_account_name = "tfstaten01663926sa"
    container_name       = "tfstatefiles"
    key           = "terraform.tfstate.assignment"

  }
}