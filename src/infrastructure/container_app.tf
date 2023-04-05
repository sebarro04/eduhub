resource "azurerm_container_app_environment" "main" {
  name                       = "main"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = "main-app"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
}

data "azurerm_subscription" "main" {
}

data "azurerm_client_config" "main" {
}

resource "azurerm_container_app" "main" {
  name                         = "main-app"
  container_app_environment_id = azurerm_container_app_environment.main.id
  resource_group_name          = azurerm_resource_group.main.name
  revision_mode                = "Single"
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.main.id]
  }
template {
    max_replicas = 10
    min_replicas = 0
    container {
      name   = "api"
      image  = "docker.io/sebarro04/api:latest"
      cpu    = "0.25"
      memory = "0.5Gi"
      env {
        name  = "ENV1"
        value = "VAL1"
      }
      env {
        name  = "ENV2"
        value = "VAL2"
      }
#      liveness_probe {
#        port      = 5000
#        timeout   = 5
#        transport = "HTTP"
#      }

#      readiness_probe {
#        port      = 5000
#        timeout   = 5
#        transport = "HTTP"
#      }

    }
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 5000
    traffic_weight {
      percentage = 100
      latest_revision = true
    }
  }
}

resource "azurerm_user_assigned_identity" "main" {
  location            = azurerm_resource_group.main.location
  name                = "owneraccess"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_role_assignment" "main" {
  scope                = data.azurerm_subscription.main.id
  role_definition_name = "Owner"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}
