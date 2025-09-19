output "OPENAI_RESOURCE_ID" {
  value     = data.azurerm_cognitive_account.this.id
  sensitive = false
}

output "OPENAI_ENDPOINT" {
  value     = "https://${data.azurerm_cognitive_account.this.name}.openai.azure.com/openai/v1/" #data.azurerm_cognitive_account.this.endpoint
  sensitive = false
}

output "OPENAI_RESOURCE_NAME" {
  value     = data.azurerm_cognitive_account.this.name
  sensitive = false
}

output "OPENAI_PRIMARY_KEY" {
  value     = data.azurerm_cognitive_account.this.primary_access_key
  sensitive = true
}