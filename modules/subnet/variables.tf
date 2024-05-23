variable "subnet_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "address_prefix" {
  type = list(string)
}

variable "service_delegation" {
  type = bool
}

