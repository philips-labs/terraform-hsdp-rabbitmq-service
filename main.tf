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
  service_plan                   = data.cloudfoundry_service.rabbitmq.service_plans[var.plan]
  replace_on_service_plan_change = true
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
  environment = merge({
    //noinspection HILUnresolvedReference
    RABBIT_URL = "https://${cloudfoundry_service_key.key.credentials.hostname}:${cloudfoundry_service_key.key.credentials.management_port}"
    //noinspection HILUnresolvedReference
    RABBIT_USER = cloudfoundry_service_key.key.credentials.username
    //noinspection HILUnresolvedReference
    RABBIT_PASSWORD = cloudfoundry_service_key.key.credentials.password
  }, var.exporter_environment)

  //noinspection HCLUnknownBlockType
  routes {
    route = cloudfoundry_route.exporter.id
  }
  labels = {
    "prometheus.io/exporter" = true,
  }
  annotations = {
    "prometheus.exporter.group"    = "rabbitmq_exporter"
    "prometheus.exporter.port"     = "9419"
    "prometheus.exporter.endpoint" = "/metrics"
  }
}

resource "cloudfoundry_route" "exporter" {
  domain   = data.cloudfoundry_domain.apps_internal_domain.id
  space    = var.cf_space_id
  hostname = "tf-rabbitmq-exporter-${local.postfix}"
}