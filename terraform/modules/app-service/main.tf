resource "azurerm_app_service_plan" "main" {
  name                = "${var.application_name}-plan"
  location            = "${data.azurerm_resource_group.group.location}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "main" {
  name                = "${var.application_name}"
  location            = "${data.azurerm_resource_group.group.location}"
  resource_group_name = "${data.azurerm_resource_group.group.name}"
  app_service_plan_id = "${azurerm_app_service_plan.main.id}"

  site_config {
    app_command_line = ""
    linux_fx_version = "DOCKER|${var.docker_image}"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "${var.docker_registry}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = "${var.docker_registry_username}"
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = "${var.docker_registry_password}"
  }
  
  lifecycle {
    ignore_changes = [
      "app_settings[\"APP_ID\"]",
      "app_settings[\"DOCKER_CUSTOM_IMAGE_NAME\"]",
      "app_settings[\"PRIVATE_KEY\"]",
      "app_settings[\"WEBHOOK_SECRET\"]",
      "app_settings[\"ARTIFACTORY_HOST\"]",
      "app_settings[\"ARTIFACTORY_USERNAME\"]",
      "app_settings[\"ARTIFACTORY_PASSWORD\"]",
      "site_config[\"linux_fx_version\"]" # deployments are made outside of Terraform
    ]
  }
}