variable "domain_name" {
  type = string

}

variable "rg_name" {
  type = string

}

variable "appgateway_a_record_name" {
  type    = string
  default = "@"

}

variable "appgateway_a_record_ttl" {
  type    = number
  default = 300

}

variable "appgateway_a_record_records" {
  type = set(string)


}