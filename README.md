# Terraform HSDP RabbitMQ service module

Provisions a HSDP RabbitMQ server instance, including a Prometheus exporter endpoint. This is for 
use with the [Thanos](https://registry.terraform.io/modules/philips-labs/thanos/cloudfoundry/latest) for custom metrics collection.

## Example 

TODO

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.1 |
| <a name="requirement_cloudfoundry"></a> [cloudfoundry](#requirement\_cloudfoundry) | >= 0.14.2 |
| <a name="requirement_hsdp"></a> [hsdp](#requirement\_hsdp) | >= 0.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudfoundry"></a> [cloudfoundry](#provider\_cloudfoundry) | >= 0.14.2 |
| <a name="provider_hsdp"></a> [hsdp](#provider\_hsdp) | >= 0.17.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudfoundry_app.exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/app) | resource |
| [cloudfoundry_route.exporter](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/route) | resource |
| [cloudfoundry_service_instance.rabbitmq](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_instance) | resource |
| [cloudfoundry_service_key.key](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/resources/service_key) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [cloudfoundry_domain.apps_internal_domain](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/domain) | data source |
| [cloudfoundry_service.rabbitmq](https://registry.terraform.io/providers/cloudfoundry-community/cloudfoundry/latest/docs/data-sources/service) | data source |
| [hsdp_config.cf](https://registry.terraform.io/providers/philips-software/hsdp/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cf_space_id"></a> [cf\_space\_id](#input\_cf\_space\_id) | Cloudfoundry space id to provision resources in | `string` | n/a | yes |
| <a name="input_exporter_disk_quota"></a> [exporter\_disk\_quota](#input\_exporter\_disk\_quota) | Exporter disk quota | `number` | `1024` | no |
| <a name="input_exporter_environment"></a> [exporter\_environment](#input\_exporter\_environment) | Additional onfiguration for the exporter | `map(any)` | `{}` | no |
| <a name="input_exporter_image"></a> [exporter\_image](#input\_exporter\_image) | Image to use for RabbitMQ exporter | `string` | `"kbudde/rabbitmq-exporter:main"` | no |
| <a name="input_exporter_memory"></a> [exporter\_memory](#input\_exporter\_memory) | Exporter memory settings | `number` | `128` | no |
| <a name="input_name_postfix"></a> [name\_postfix](#input\_name\_postfix) | The postfix string to append to the space, hostname, etc. Prevents namespace clashes | `string` | `""` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | Plan to use | `string` | `"rabbitmq-dev-standalone"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metrics_app_id"></a> [metrics\_app\_id](#output\_metrics\_app\_id) | The metrics app ID |
| <a name="output_metrics_host"></a> [metrics\_host](#output\_metrics\_host) | The exporter metrics internal hostname |
| <a name="output_metrics_port"></a> [metrics\_port](#output\_metrics\_port) | The exporter metrics internal port |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | The service id |
<!--- END_TF_DOCS --->

# Contact / Getting help

Please post your questions on the HSDP Slack `#terraform` channel, or start a [discussion](https://github.com/philips-labs/terraform-hsdp-rabbitmq-service/discussions)

# License

License is MIT
