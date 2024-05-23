resource "azurerm_container_app_environment" "aca-environment" {
  name                           = var.aca_env_name
  location                       = var.location
  resource_group_name            = var.rg_name
  infrastructure_subnet_id       = var.subnet_id
  zone_redundancy_enabled        = var.zone_redundancy_enabled
  internal_load_balancer_enabled = var.internal_load_balancer_enabled

  workload_profile {
    name                  = var.workload_profile_name
    workload_profile_type = var.workload_profile_type
    minimum_count         = var.workload_profile_min_count
    maximum_count         = var.workload_profile_max_count
  }
}