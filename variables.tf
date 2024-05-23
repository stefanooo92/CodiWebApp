variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}


variable "vnet_name" {
  type = string
}


variable "address_space" {
  type = list(string)
}


#subnet
variable "aca_subnet_name" {
  type = string
}

variable "appgtw_subnet_name" {
  type = string
}



variable "aca_address_prefix" {
  type = list(string)
}

variable "appgtw_address_prefix" {
  type = list(string)
}





#aca env
variable "aca_env_name" {
  type = string
}


variable "workload_profile_name" {
  type = string
}

variable "workload_profile_type" {
  type = string
}

variable "workload_profile_min_count" {
  type = number
}

variable "workload_profile_max_count" {
  type = number
}

#aca
variable "aca_name" {
  type = string
}


variable "revision_mode" {
  type = string
}

variable "target_port" {
  type = number
}

variable "min_replicas" {
  type = number
}


variable "max_replicas" {
  type = number
}

variable "container" {
  type = string

}

variable "image" {
  type = string

}

variable "cpu" {
  type = number
}

variable "memory" {
  type = string

}

#publicdns
variable "domain_name" {
  type = string

}

#wafpolicy
variable "waf_policy_name" {
  type = string

}

variable "custom_rules" {
  description = "List of custom rules for the WAF policy"
  type = list(object({
    name           = string
    priority       = number
    rule_type      = string
    match_variable = string
    operator       = string
    negation       = bool
    match_values   = list(string)
    action         = string
  }))
}

#app-gateway
variable "appgateway_name" {
  type = string

}

variable "port_http" {
  type = number

}

variable "port_https" {
  type = number

}

#nsg
variable "nsg_name" {
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