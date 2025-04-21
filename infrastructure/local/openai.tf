module "openai" {
  depends_on = [ 
    azurerm_resource_group.app,
  ]
  source               = "${local.module_path}/openai"
  resource_name        = local.resource_name
  resource_group = {
    location = azurerm_resource_group.app.location
    name     = azurerm_resource_group.app.name
  }
  log_analytics ={ 
    deploy       = false
    workspace_id = ""
  }
}