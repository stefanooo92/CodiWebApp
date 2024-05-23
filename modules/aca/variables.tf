variable "aca_name" {
  type = string
}

variable "aca_env_id" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "workload_profile_name" {
  type = string
}

variable "revision_mode" {
  type = string
}

variable "allow_insecure_connections" {
  type    = bool
  default = false
}

variable "target_port" {
  type = number
}

variable "external_enabled" {
  type    = bool
  default = true
}

variable "ingress_transport" {
  type    = string
  default = "auto"
}

variable "latest_revision" {
  type    = bool
  default = true
}

variable "percentage" {
  type    = number
  default = 100
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

variable "transport" {
  type    = string
  default = "HTTP"
}

variable "timeout" {
  type    = number
  default = 1
}

variable "initial_delay" {
  type    = number
  default = 1
}

variable "interval_seconds" {
  type    = number
  default = 15
}

variable "failure_count_threshold" {
  type    = number
  default = 5
}

variable "path" {
  type    = string
  default = "/"
}

variable "http_scale_rule" {
  type    = string
  default = "scale-rule-1000"
}

variable "concurrent_requests" {
  type    = number
  default = 1000
}
