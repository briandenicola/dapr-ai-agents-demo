# Overview
This repository contains the code for the Seven Hills of Rome project, which is a sample application that demonstrates how to use Dapr and Azure services to build a scalable, reliable and secure Agentic AI Application. The project is built using Python, Flask, and Azure services such as Azure Kubernetes Service (AKS), Azure Container Registry (ACR), and Azure OpenAI.

The project relies on the following project - [Dapr Virtual Agent](https://github.com/dapr/dapr-agents) - which is currently in Alpha so please be aware that the code may change in the future. The Dapr Virtual Agent is a framework for building conversational agents using Dapr and Azure services. It provides a set of components and APIs for building, deploying, and managing conversational agents.

## Prerequisites
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html)
- [Taskfile](https://taskfile.dev/installation/)

## Usage
* task: Available tasks for this project:
    | Task |  Description | 
    | ------ | ------ |
    | `azure:build`|         Builds application via ACR tasks
    | `azure:core`|        Deploys Istio Certificate and Otel infrastructure via Helm/GitOps
    | `azure:creds`|         Gets credential file for newly created AKS cluster
    | `azure:deploy`|        Deploys application via Helm/GitOps
    | `azure:dns`|           Gets the IP Address of the Istio Gateway
    | `azure:down`|          Destroys all Azure resources and cleans up Terraform
    | `azure:init`|         Initializes Terraform for The Seven Hills of Rome
    | `azure:restart`|       Performs a rollout restart on all deployments in rome namespace
    | `azure:up`|            Creates a complete Azure environment for The Seven Hills of Rome
    | `local:apply`|         Applies Terraform configuration for The Seven Hills of Rome (local)
    | `local:creds`|         Outputs Open AI Endpoint and KEY to .env file
    | `local:down`|          Destroys all resources and cleans up Terraform for The Seven Hills of Rome (local)
    | `local:env`|           Preps virtual environment
    | `local:refresh`|       Refreshes Terraform configuration for The Seven Hills of Rome (local)
    | `local:run`|           Starts dapr and runs the application
    | `local:up`|            Creates a Development Environment for The Seven Hills of Rome (local)

# Local Environment Setup
The local environment creates the following resources:
- An Azure OpenAI resource for the OpenAI API.
- All containers are built and deployed with Docker Compose.

## Steps
1. Create Azure Resources
    ```bash
    az login 
    task local:up
    task local:creds
    task local:run
    ```
## Validate 

__TBD__

## Clean up
```bash
    task task:down
```

# Azure Environment Setup

The Azure environment creates the following resources:
- An Azure Kubernetes Service (AKS) cluster with a private endpoint.
- An Azure Container Registry (ACR) with a private endpoint.
- An Azure OpenAI resource for the OpenAI API.
- An Azure Virtual Network (VNet) with subnets for the AKS and ACR.
- An Azure Key Vault for storing secrets.
- An Azure Log Analytics workspace for monitoring and logging.
- An Azure Application Insights resource for monitoring the AKS cluster.
- 3 Azure Resource Groups to contain all the resources.
- An Azure Private DNS Zone for the AKS and ACR private endpoints.
- An Azure Private DNS Zone Group to link the private DNS zone to the AKS and ACR.

## Steps
### Prerequisites  
1. The code requires an SSL certificate for the ISTIO Gateway and a public DNS domain for the application.
1. After the SSL certificate is created, export the certificate and private key to a `.pfx` file.
1. Create a .env file in the infrastructure folder with the following variables:
    - CERT_PFX_PASS=${your_password_for_the_pfx_file}
    - CERT_PATH=${path_to_the_pfx_file}
    - DEFAULT_DOMAIN=${domain_of_the_certificate_like_contoso.com}

### Deployment Steps
1. Create Azure Resources
    ```bash
        az login 
        task azure:up
        task azure:build
        task azure:deploy

## Validate 

__TBD__

## Clean up
```bash
    task azure:down
```

