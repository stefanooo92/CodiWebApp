resource "azurerm_public_ip" "appgateway_ip" {
  name                = var.appgateway_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
  zones               = var.zones
}

resource "azurerm_application_gateway" "aca_appgateway" {
  name                = var.appgateway_name
  resource_group_name = var.rg_name
  location            = var.location
  zones               = var.zones

  sku {
    name = var.appgtw_sku
    tier = var.appgtw_sku
  }

  autoscale_configuration {
    min_capacity = var.autoscale_configuration_min_capacity
    max_capacity = var.autoscale_configuration_max_capacity
  }

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  ssl_certificate {
    name                = var.ssl_certificate_name
    key_vault_secret_id = var.key_vault_secret_id
  }

  gateway_ip_configuration {
    name      = var.gateway_ip_name
    subnet_id = var.gateway_ip_subnet_id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-configuration"
    public_ip_address_id = azurerm_public_ip.appgateway_ip.id
  }

  frontend_port {
    name = "frontend-port-http"
    port = var.port_http
  }

  frontend_port {
    name = "frontend-port-https"
    port = var.port_https
  }

  backend_address_pool {
    name  = "backend-address-pool"
    fqdns = var.backend_address_pool_fqdn
  }

  backend_http_settings {
    name                                = "backend-http-settings-https"
    port                                = var.port_https
    protocol                            = "Https"
    cookie_based_affinity               = "Disabled"
    pick_host_name_from_backend_address = var.pick_host_name_from_backend_address
    affinity_cookie_name                = "ApplicationGatewayAffinity"
    request_timeout                     = var.request_timeout
    probe_name                          = "http-health-probe"
  }

  http_listener {
    name                           = "listener-http"
    frontend_ip_configuration_name = "frontend-ip-configuration"
    frontend_port_name             = "frontend-port-http"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "listener-https"
    frontend_ip_configuration_name = "frontend-ip-configuration"
    frontend_port_name             = "frontend-port-https"
    protocol                       = "Https"
    ssl_certificate_name           = var.domain_name
  }

  # HTTP Routing Rule - HTTP to HTTPS Redirect
  request_routing_rule {
    name                        = "request-routing-rule-http"
    rule_type                   = "Basic"
    priority                    = 1
    http_listener_name          = "listener-http"
    redirect_configuration_name = "redirect-configuration"
  }

  # HTTPS Routing Rule - Port 443
  request_routing_rule {
    name                       = "request-routing-rule-https"
    rule_type                  = "Basic"
    priority                   = 2
    http_listener_name         = "listener-https"
    backend_address_pool_name  = "backend-address-pool"
    backend_http_settings_name = "backend-http-settings-https"
  }

  redirect_configuration {
    name                 = "redirect-configuration"
    redirect_type        = "Permanent"
    target_listener_name = "listener-https"
    include_path         = true
    include_query_string = true
  }

  probe {
    name                                      = "http-health-probe"
    protocol                                  = "Https"
    pick_host_name_from_backend_http_settings = true
    path                                      = "/"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    minimum_servers                           = 0

    match {
      status_code = ["200-399"]
    }
  }

  firewall_policy_id = var.firewall_policy_id
}