terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      version = ">= 3.27.0"
      source  = "hashicorp/azurerm"
    }
  }

  backend "azurerm" {
    resource_group_name  = "or-test-rg"
    storage_account_name = "ortfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}