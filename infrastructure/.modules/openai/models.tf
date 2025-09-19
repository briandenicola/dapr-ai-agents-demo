resource "azurerm_cognitive_deployment" "this" {
  count                = length(var.llm_model)
  name                 = var.llm_model[count.index].deployment_name
  cognitive_account_id = data.azurerm_cognitive_account.this.id
  model {
    format  = "OpenAI"
    name    = var.llm_model[count.index].name
    version = var.llm_model[count.index].version
  }

  sku {
    name     = var.llm_model[count.index].sku_type
    capacity = 10
  }
}
