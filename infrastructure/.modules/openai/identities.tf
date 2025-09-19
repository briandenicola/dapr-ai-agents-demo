resource "azurerm_user_assigned_identity" "aks_identity" {
  name                = "${local.openai_name}-identity"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}

