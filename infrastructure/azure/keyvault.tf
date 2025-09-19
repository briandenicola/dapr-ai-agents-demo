
resource "azurerm_key_vault" "this" {
  name                        = local.app_keyvault_name
  resource_group_name         = azurerm_resource_group.app.name
  location                    = azurerm_resource_group.app.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false  
  rbac_authorization_enabled =  true

  sku_name                    = "standard"

  network_acls {
    bypass                    = "AzureServices"
    default_action            = "Deny"
    ip_rules                  = ["${local.home_ip_address}/32"] 
  }
}

