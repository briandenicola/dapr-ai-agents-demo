resource "azurerm_private_endpoint" "acr_account" {
  depends_on = [
    module.cluster
  ]
  name                = "${local.acr_name}-endpoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${local.acr_name}-endpoint"
    private_connection_resource_id = module.cluster.ACR_RESOURCE_ID
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_azurecr_io.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_azurecr_io.id]
  }
}

resource "azurerm_private_endpoint" "key_vault" {
  depends_on = [
    module.cluster
  ]
  name                = "${local.keyvault_name}-endpoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${local.keyvault_name}-endpoint"
    private_connection_resource_id = module.cluster.KEYVAULT_RESOURCE_ID
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_vault_core_azure_net.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_vault_core_azure_net.id]
  }
}

resource "azurerm_private_endpoint" "app_key_vault" {
  depends_on = [
    azurerm_key_vault.this
  ]
  name                = "${local.app_keyvault_name}-endpoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${local.app_keyvault_name}-endpoint"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_vault_core_azure_net.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_vault_core_azure_net.id]
  }
}

resource "azurerm_private_endpoint" "servicebus_namespace" {
  name                = "${local.sb_name}-endpoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.pe.id

  private_service_connection {
    name                           = "${local.sb_name}-endpoint"
    private_connection_resource_id = azurerm_servicebus_namespace.this.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
  }
}
