variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  type        = string
  default     = "westeurope"
}

variable "resource_group_to_create" {
  description = "Specifies whether to create or not to create a new resource group"
  type        = bool
  default     = false
}

variable "resource_group_name" {
  description = "Specifies the resource group name of the ACR"
  type        = string
  default     = "or-test-rg"
}

variable "environment" {
  description = "The environment in which the ACR will be deployed"
  type        = string
  default     = "Test"
}

# ACR configuration
variable "acr_name" {
  description = "(Required) Specifies the name of the ACR"
  type        = string
}

variable "sku_tier" {
  description = "(Required) The SKU name of the container registry. Possible values are Basic, Standard and Premium"
  default     = "Premium"
  type        = string
}

variable "public_network_access_enabled" {
  description = "Optional) Whether public network access is allowed for the container registry"
  default     = false
  type        = bool
}

# Network variables
variable "network_list" {
  type = list(object({
    number         = number
    vnet           = string
    subnet         = string
    resource_group = string
  }))
  default = [ {
    number         = 1
    vnet           = "cloud-shell-storage-westeurope-vnet"
    subnet         = "aks"
    resource_group = "cloud-shell-storage-westeurope"
  } ]
}

variable "ip_list" {
  description = "(Required) The CIDR block from which requests will match the rule"
  type        = list(string)
}