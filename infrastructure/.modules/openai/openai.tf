data "azurerm_monitor_diagnostic_categories" "this" {
  resource_id = data.azurerm_cognitive_account.this.id
}

# resource "azurerm_cognitive_account" "this" {
#   name                  = local.openai_name
#   resource_group_name   = var.resource_group.name
#   location              = var.resource_group.location
#   kind                  = "AIServices"
#   custom_subdomain_name = local.openai_name
#   sku_name              = "S0"
# }

resource "azapi_resource" "ai_foundry" {
  type      = "Microsoft.CognitiveServices/accounts@2025-06-01"
  name      = local.openai_name
  location  = var.resource_group.location
  parent_id = var.resource_group.id

  identity {
    type = "SystemAssigned, UserAssigned"
    identity_ids = [
        azurerm_user_assigned_identity.aks_identity.id
    ]
  }  

  body = {
    sku = {
      name = "S0"
    },
    kind = "AIServices",
    properties = {
      allowProjectManagement = true
      customSubDomainName =  local.openai_name
      publicNetworkAccess = "Enabled"
    }
  }
}

data "azurerm_cognitive_account" "this" {
  depends_on          = [azapi_resource.ai_foundry]
  name                = local.openai_name
  resource_group_name = var.resource_group.name
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = var.log_analytics.deploy ? 1 : 0

  depends_on = [
    data.azurerm_monitor_diagnostic_categories.this
  ]

  name                       = "diag"
  target_resource_id         = data.azurerm_cognitive_account.this.id
  log_analytics_workspace_id = var.log_analytics.workspace_id

  dynamic "enabled_log" {
    for_each = toset(data.azurerm_monitor_diagnostic_categories.this.log_category_types)
    content {
      category = enabled_log.value
    }

  }

  enabled_metric {
    category = "AllMetrics"
  }
}
