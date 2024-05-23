variable "nsg_name" {
  type = string

}

variable "rg_name" {
  type = string
}

variable "location" {
  type = string

}

variable "security_rules" {
  description = "List of security rules for the Network Security Group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "nsg_association_subnet_id" {
  type = string

}