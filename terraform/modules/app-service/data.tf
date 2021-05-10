# Get reference to resource group
data "azurerm_resource_group" "group" {
  name = "${var.resource_group_name}"
}

locals {
  # Set of standard tags to apply to resources
  standard_tags = {
    environment      = "${var.environment}"
    application-name = "${var.application_name}"
    cost-center      = "${var.cost_center}"
    owner            = "${var.owner}"
  }
}
