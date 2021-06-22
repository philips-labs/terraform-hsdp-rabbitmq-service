data "cloudfoundry_org" "org" {
  name = var.cf_org_name
}

data "cloudfoundry_space" "space" {
  org  = data.cloudfoundry_org.org.id
  name = var.cf_space_name
}

module "thanos" {
  source = "philips-labs/thanos/cloudfoundry"

  cf_org_name = "test"
  cf_space_id = data.cloudfoundry_space.space.id
  grafana_password = "supersecret"
}

module "rabbitmq" {
  source      = "philips-labs/rabbitmq-service/hsdp"
  cf_space_id = data.cloudfoundry_space.space.id
}

resource "cloudfoundry_network_policy" "rabbitmq_exporter" {
  policy {
    source_app      = module.thanos.thanos_app_id
    destination_app = module.rabbitmq.metrics_app_id
    port            = module.rabbitmq.metrics_port
  }
}
