module "openai" {
  depends_on = [ 
    azurerm_resource_group.app,
  ]
  source               = "../.modules/openai"
  resource_name        = local.resource_name
  resource_group = {
    location = azurerm_resource_group.app.location
    name     = azurerm_resource_group.app.name
  }
  log_analytics ={ 
    deploy       = false
    workspace_id = ""
  }
  llm_model = [{
    name            = "gpt-4o"
    deployment_name = "gpt-4o"
    version         = "2024-11-20"
    sku_type        = "GlobalStandard"
  },
  {
    name            = "o1"
    deployment_name = "o1"
    version         = "2024-12-17"
    sku_type        = "GlobalStandard"
  },
  {
    name            = "gpt-4.1"
    deployment_name = "gpt-4.1"
    version         = "2024-12-01-preview"
    sku_type        = "GlobalStandard"
  }] 
}