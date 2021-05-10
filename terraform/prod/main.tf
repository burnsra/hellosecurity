module "app_service_instance" {
  source                   = "../modules/app-service"
  application_name         = var.application_name
  environment              = "prod"
  resource_group_name      = var.resource_group_name
  cost_center              = var.cost_center
  owner                    = var.owner
  docker_image             = var.docker_image
  docker_registry          = var.docker_registry 
  docker_registry_username = var.docker_registry_username
  docker_registry_password = var.docker_registry_password
}