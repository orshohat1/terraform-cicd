# Creating a new resource group or not
resource "azurerm_resource_group" "rg" {
  count    = var.resource_group_to_create == true ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = "${var.dns_prefix}-${var.aks_cluster_name}"
  #private_dns_zone_id       = data.azurerm_private_dns_zone.aks_private_zone.id
  private_cluster_enabled   = true
  automatic_channel_upgrade = var.automatic_channel_upgrade
  sku_tier                  = var.sku_tier
  oidc_issuer_enabled       = var.workload_identity_enabled
  workload_identity_enabled = var.workload_identity_enabled

  # Node pool configuration
  default_node_pool {
    name                  = var.default_node_pool_name
    vm_size               = var.default_node_pool_vm_size
    vnet_subnet_id        = data.azurerm_subnet.aks_subnet.id
    enable_auto_scaling   = var.default_node_pool_enable_auto_scaling
    enable_node_public_ip = var.default_node_pool_enable_node_public_ip
    max_count             = var.default_node_pool_max_count
    min_count             = var.default_node_pool_min_count
    node_count            = var.default_node_pool_node_count
  }

  # Assign the created cluster identity to the node pool
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.aks_identity.id]
  }

  # Integrating with AAD
  azure_active_directory_role_based_access_control {
    managed                = var.azure_rbac_enabled
    azure_rbac_enabled     = var.azure_rbac_enabled
    admin_group_object_ids = var.admin_group_object_ids
  }

  # Assign the kubelet identity
  kubelet_identity {
    client_id                 = data.azurerm_user_assigned_identity.aks_kubelet_identity.client_id
    object_id                 = data.azurerm_user_assigned_identity.aks_kubelet_identity.principal_id
    user_assigned_identity_id = data.azurerm_user_assigned_identity.aks_kubelet_identity.id
  }

  # Azure application gateway ingress controller integration
  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway.enabled == true ? [1] : []

    content {
      gateway_id = var.ingress_application_gateway.gateway_id
    }
  }

  tags = local.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_nodepools" {
  for_each              = { for k, v in var.nodepools_list : k => v if var.additional_node_pools_to_create }
  name                  = each.value.nodepool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_cluster.id
  vm_size               = each.value.vm_size
  enable_auto_scaling   = each.value.enable_auto_scaling
  enable_node_public_ip = each.value.enable_node_public_ip
  max_count             = each.value.max_count
  min_count             = each.value.min_count
  node_count            = each.value.node_count
}