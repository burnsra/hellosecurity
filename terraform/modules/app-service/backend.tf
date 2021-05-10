terraform {
  backend "azurerm" {
    resource_group_name  = "${var.resource_group_name}"
  }
}

provider "azurerm" {
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=1.34.0"
}
