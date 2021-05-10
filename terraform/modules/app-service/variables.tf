variable "application_name" {
  description = "Application name"
}

variable "resource_group_name" {
  description = "Azure resource group name"
}

variable "environment" {
  description = "Environment name"
  default = "nonprod"
}

variable "cost_center" {
  description = "Cost center"
  default = "NA"
}

variable "owner" {
  description = "Owner"
  default = "NA"
}

variable "docker_registry" {
  description = "Docker registry URL"
  default = "https://index.docker.io"
}

variable "docker_registry_username" {
  description = "Docker registry username"
  default = ""
}

variable "docker_registry_password" {
  description = "Docker registry password"
  default = ""
}

variable "docker_image" {
  description = "Docker image"
  default = "library/nginx:latest"
}