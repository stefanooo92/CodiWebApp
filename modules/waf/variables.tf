variable "waf_policy_name" {
  type = string

}

variable "rg_name" {
  type = string

}

variable "location" {
  type = string

}

variable "policy_settings_enabled" {
  type    = bool
  default = true

}

variable "policy_settings_mode" {
  type    = string
  default = "Prevention"

}

variable "request_body_check" {
  type    = bool
  default = true
}

variable "file_upload_limit_in_mb" {
  type    = number
  default = 100

}

variable "max_request_body_size_in_kb" {
  type    = number
  default = 128

}

variable "managed_rule_set_type" {
  type    = string
  default = "OWASP"

}

variable "managed_rule_set_version" {
  type    = string
  default = "3.2"

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