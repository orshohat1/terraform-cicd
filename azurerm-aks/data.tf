# Network
data "azurerm_virtual_network" "vnet" {
  name                = var.aks_vnet_name
  resource_group_name = var.aks_vnet_resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = var.aks_vnet_resource_group_name
}

# Managed identities
data "azurerm_user_assigned_identity" "aks_identity" {
  name                = var.managed_identities.aks_identity_name
  resource_group_name = var.managed_identities.resource_group_name
}

data "azurerm_user_assigned_identity" "aks_kubelet_identity" {
  name                = var.managed_identities.aks_kubelet_identity_name
  resource_group_name = var.managed_identities.resource_group_name
}