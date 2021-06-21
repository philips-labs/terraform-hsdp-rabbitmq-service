locals {
  postfix = var.name_postfix != "" ? var.name_postfix : random_id.id.hex
}

resource "random_id" "id" {
  byte_length = 8
}

resource "cloudfoundry_service_instance" "rabbitmq" {
  name  = "tf-rabbitmq-${local.postfix}"
  space = var.cf_space_id
  //noinspection HILUnresolvedReference
  service_plan = data.cloudfoundry_service.rabbitmq.service_plans[var.plan]
}

resource "cloudfoundry_service_key" "key" {
  name             = "key"
  service_instance = cloudfoundry_service_instance.rabbitmq.id
}

resource "cloudfoundry_app" "exporter" {
  name         = "tf-rabbitmq-exporter-${local.postfix}"
  space        = var.cf_space_id
  docker_image = var.exporter_image
  disk_quota   = var.exporter_disk_quota
  memory       = var.exporter_memory
  environment = merge({},
  var.exporter_environment)

  //noinspection HCLUnknownBlockType
  routes {
    route = cloudfoundry_route.exporter.id
  }
}

resource "cloudfoundry_route" "exporter" {
  domain   = data.cloudfoundry_domain.apps_internal_domain
  space    = var.cf_space_id
  hostname = "tf-rabbitmq-exporter-${local.postfix}"
}