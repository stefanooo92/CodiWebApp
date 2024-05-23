variable "aca_env_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_id" {
  type = string
}


variable "zone_redundancy_enabled" {
  type    = bool
  default = true
}

variable "internal_load_balancer_enabled" {
  type    = bool
  default = true
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