variable "private_dns_zone_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "dns_a_record_name" {
  type    = string
  default = "@"
}

variable "dns_a_record_ttl" {
  type    = number
  default = 300
}

variable "dns_a_record_records" {
  type = set(string)

}

variable "wildcard_dns_a_record_name" {
  type    = string
  default = "*"
}

variable "wildcard_dns_a_record_records" {
  type = set(string)

}

variable "dns_link_name" {
  type    = string
  default = "dns_to_vnet"
}

variable "virtual_network_id" {
  type = string

}