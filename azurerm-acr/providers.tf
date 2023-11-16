terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      version = ">= 3.27.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {

  }
}