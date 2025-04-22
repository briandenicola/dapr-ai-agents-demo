resource "azurerm_servicebus_namespace" "this" {
  name                         = local.sb_name
  location                     = azurerm_resource_group.app.location
  resource_group_name          = azurerm_resource_group.app.name
  sku                          = "Premium"
  premium_messaging_partitions = 1
  capacity                     = 1
}

