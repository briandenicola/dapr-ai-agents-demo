
resource "azurerm_role_assignment" "keda_sb_data_owner" {
  scope                            = azurerm_servicebus_namespace.this.id
  role_definition_name             = "Azure Service Bus Data Owner"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "metric_publisher" {
  scope                            = module.azure_monitor.LOG_ANALYTICS_RESOURCE_ID
  role_definition_name             = "Monitoring Metrics Publisher"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "ai_metric_publisher" {
  scope                            = module.azure_monitor.APP_INSIGHTS_RESOURCE_ID
  role_definition_name             = "Monitoring Metrics Publisher"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "local_user_openai_user" {
  scope                            = module.openai.OPENAI_RESOURCE_ID
  role_definition_name             = "Cognitive Services OpenAI User"
  principal_id                     = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "app_openai_user" {
  scope                            = module.openai.OPENAI_RESOURCE_ID
  role_definition_name             = "Cognitive Services OpenAI User"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
}

resource "azurerm_role_assignment" "admin" {
  scope                            = azurerm_key_vault.this.id
  role_definition_name             = "Key Vault Administrator"
  principal_id                     = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "secret_user" {
  scope                            = azurerm_key_vault.this.id
  role_definition_name             = "Key Vault Secrets User"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "storage_data_reader" {
  scope                            = azurerm_storage_account.this.id
  role_definition_name             = "Storage Blob Data Reader"
  principal_id                     = azurerm_user_assigned_identity.app_identity.principal_id
  skip_service_principal_aad_check = true
}