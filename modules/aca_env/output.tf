output "aca_env_id" {
  value = azurerm_container_app_environment.aca-environment.id
}

output "aca_env_default_domain" {
  value = azurerm_container_app_environment.aca-environment.default_domain
}

output "aca_env_static_ip" {
  value = azurerm_container_app_environment.aca-environment.static_ip_address
}