resource "azurerm_container_app" "aca-app" {
  name                         = var.aca_name
  container_app_environment_id = var.aca_env_id
  resource_group_name          = var.rg_name
  workload_profile_name        = var.workload_profile_name
  revision_mode                = var.revision_mode


  ingress {
    allow_insecure_connections = var.allow_insecure_connections
    target_port                = var.target_port
    external_enabled           = var.external_enabled
    transport                  = var.ingress_transport


    traffic_weight {
      latest_revision = var.latest_revision
      percentage      = var.percentage
    }
  }


  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = var.container
      image  = var.image
      cpu    = var.cpu
      memory = var.memory
      liveness_probe {
        port                    = var.target_port
        transport               = var.transport
        timeout                 = var.timeout
        initial_delay           = var.initial_delay
        interval_seconds        = var.interval_seconds
        failure_count_threshold = var.failure_count_threshold
        path                    = var.path
      }

    }

    http_scale_rule {
      name                = var.http_scale_rule
      concurrent_requests = var.concurrent_requests
    }

  }


}