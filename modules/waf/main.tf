resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = var.waf_policy_name
  resource_group_name = var.rg_name
  location            = var.location

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type

      match_conditions {
        match_variables {
          variable_name = custom_rules.value.match_variable
        }

        operator           = custom_rules.value.operator
        negation_condition = custom_rules.value.negation
        match_values       = custom_rules.value.match_values
      }

      action = custom_rules.value.action
    }
  }



  policy_settings {
    enabled                     = var.policy_settings_enabled
    mode                        = var.policy_settings_mode
    request_body_check          = var.request_body_check
    file_upload_limit_in_mb     = var.file_upload_limit_in_mb
    max_request_body_size_in_kb = var.max_request_body_size_in_kb
  }

  managed_rules {

    managed_rule_set {
      type    = var.managed_rule_set_type
      version = var.managed_rule_set_version
    }
  }
}