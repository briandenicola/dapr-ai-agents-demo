resource "azurerm_postgresql_flexible_server" "this" {
  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.privatelink_postgres_database_azure_com
  ]
  name                          = local.sql_name
  resource_group_name           = azurerm_resource_group.app.name
  location                      = azurerm_resource_group.app.location
  delegated_subnet_id           = azurerm_subnet.sql.id
  private_dns_zone_id           = azurerm_private_dns_zone.privatelink_postgres_database_azure_com.id
  version                       = "15"
  administrator_login           = local.postgresql_user_name
  administrator_password        = random_password.postgresql_user_password.result
  public_network_access_enabled = false
  storage_mb                    = 32768
  sku_name                      = "GP_Standard_D2ds_v4"
  zone                          = "2"
}

resource "azurerm_postgresql_flexible_server_database" "agent_state" {
  name      = local.postgresql_agent_state_database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}

resource "azurerm_postgresql_flexible_server_database" "workflow_state" {
  name      = local.postgresql_workflow_state_database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
