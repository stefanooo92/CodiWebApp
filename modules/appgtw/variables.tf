variable "appgateway_ip_name" {
  type    = string
  default = "appgateway_ip"

}

variable "rg_name" {
  type = string

}

variable "location" {
  type = string

}

variable "allocation_method" {
  type    = string
  default = "Static"

}
variable "sku" {
  type    = string
  default = "Standard"

}

variable "zones" {
  type    = set(string)
  default = [1, 2, 3]

}

variable "appgateway_name" {
  type = string

}

variable "appgtw_sku" {
  type    = string
  default = "WAF_v2"

}

variable "autoscale_configuration_min_capacity" {
  type    = number
  default = 2

}

variable "autoscale_configuration_max_capacity" {
  type    = number
  default = 10

}

variable "identity_type" {
  type    = string
  default = "UserAssigned"
}

variable "identity_ids" {
  type = set(string)

}

variable "ssl_certificate_name" {
  type = string

}

variable "key_vault_secret_id" {
  type = string

}

variable "gateway_ip_name" {
  type    = string
  default = "appgateway-ip"

}

variable "gateway_ip_subnet_id" {
  type = string

}

variable "port_http" {
  type = number

}

variable "port_https" {
  type = number

}

variable "backend_address_pool_fqdn" {
  type = set(string)

}

variable "pick_host_name_from_backend_address" {
  type    = bool
  default = true

}

variable "request_timeout" {
  type    = number
  default = 20

}

variable "domain_name" {
  type = string

}

variable "firewall_policy_id" {
  type = string

}