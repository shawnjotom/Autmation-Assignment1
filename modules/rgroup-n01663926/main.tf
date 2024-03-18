terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.88.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "n01663926_RG" {
  name     = var.resource_group_name
  location = var.location
}



