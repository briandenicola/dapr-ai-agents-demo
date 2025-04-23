resource "azurerm_key_vault_secret" "service_bus_connection_string" {
  depends_on = [
    azurerm_role_assignment.admin
  ]
  name         = local.service_bus_secret_name
  value        = azurerm_servicebus_namespace.this.default_primary_connection_string
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "workflow_postgresql_connection_string" {
  depends_on = [
    azurerm_role_assignment.admin
  ]
  name         = local.workflow_postgresql_secret_name
  value        = "host=${local.sql_name}.postgres.database.azure.com user=${local.postgresql_user_name} password=${random_password.postgresql_user_password.result} port=5432 dbname=${local.postgresql_workflow_state_database_name} sslmode=require"
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "agents_postgresql_connection_string" {
  depends_on = [
    azurerm_role_assignment.admin
  ]
  name         = local.agent_postgresql_secret_name
  value        = "host=${local.sql_name}.postgres.database.azure.com user=${local.postgresql_user_name} password=${random_password.postgresql_user_password.result} port=5432 dbname=${local.postgresql_agent_state_database_name} sslmode=require"
  key_vault_id = azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "azure_open_key" {
  depends_on = [
    azurerm_role_assignment.admin
  ]
  name         = local.azure_openai_secret_name
  value        = module.openai.OPENAI_API_KEY
  key_vault_id = azurerm_key_vault.this.id
}