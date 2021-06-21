variable "cf_space_id" {
  description = "Cloudfoundry space id to provision resources in"
  type        = string
}

variable "name_postfix" {
  type        = string
  description = "The postfix string to append to the space, hostname, etc. Prevents namespace clashes"
  default     = ""
}

variable "exporter_image" {
  description = "Image to use for RabbitMQ exporter"
  default     = "kbudde/rabbitmq-exporter:main"
  type        = string
}

variable "plan" {
  description = "Plan to use"
  type        = string
  default     = "rabbitmq-dev-standalone"
}

variable "exporter_memory" {
  type        = number
  description = "Exporter memory settings"
  default     = 128
}

variable "exporter_disk_quota" {
  type        = number
  description = "Exporter disk quota"
  default     = 1024
}

variable "exporter_environment" {
  type        = map(any)
  description = "Additional onfiguration for the exporter"
  default     = {}
}
