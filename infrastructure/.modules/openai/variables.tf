variable "resource_name" {
  description = "The root value to use for naming resources"
}

variable "llm_model" {
  description = "The LLM model to use"
  type = list(object({
    name            = string
    deployment_name = string
    version         = string
    sku_type        = string
  }))
}

variable "resource_group" {
  description = "The resource group to deploy resources to"
  type = object({
    name     = string
    location = string
  })
}

variable "log_analytics" {
  description = "The Log Analytics Workspace ID to use for diagnostic settings"
  type = object({
    deploy       = bool
    workspace_id = string
  })
}
