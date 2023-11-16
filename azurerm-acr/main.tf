# Creating a new resource group or not
resource "azurerm_resource_group" "rg" {
  count    = var.resource_group_to_create == true ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

# ACR
resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku_tier
  public_network_access_enabled = var.public_network_access_enabled

  # Network policies
  network_rule_set {
    default_action  = "Deny"
    virtual_network = local.allowrd_virtual_networks
    ip_rule         = local.allowed_ip_list
  }

  tags = local.tags
}