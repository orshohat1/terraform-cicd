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
  description = "Specifies the resource group name of the AKS cluster"
  type        = string
  default     = "or-test-rg"
}

variable "environment" {
  description = "The environment in which the AKS cluster will be deployed"
  type        = string
  default     = "Test"
}

# Cluster configuration
variable "aks_cluster_name" {
  description = "(Required) Specifies the name of the AKS cluster"
  type        = string
}

variable "automatic_channel_upgrade" {
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none"
  type        = string
  default     = "patch"

  validation {
    condition     = contains(["patch", "rapid", "stable", "none"], var.automatic_channel_upgrade)
    error_message = "The upgrade mode is invalid"
  }
}

variable "sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free, and Standard (which includes the Uptime SLA)"
  default     = "Free"
  type        = string

  validation {
    condition     = contains(["Free", "Paid"], var.sku_tier)
    error_message = "The sku tier is invalid"
  }
}

variable "node_lables" {
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool"
  default     = "default"
  type        = string
}

variable "kubernetes_version" {
  description = "Specifies the AKS kubernetes version"
  default     = "1.28.0"
  type        = string
}

variable "dns_prefix" {
  description = "Specifies the dns prefix of the cluster"
  default     = "test"
  type        = string
}
# Network data variables
variable "aks_vnet_resource_group_name" {
  description = "Specifies the name of the AKS vnet resource group"
  type        = string
}

variable "aks_vnet_name" {
  description = "Specifies the name of the AKS vnet"
  type        = string
}

variable "aks_subnet_name" {
  description = "Specifies the name of the AKS subnet"
  type        = string
}

# variable "dns_zone_name" {
#   description = "Specifies the name of the AKS private DNS zone"
#   type        = string
# }

# variable "dns_resource_group_name" {
#   description = "Specifies the name of the private DNS zone resource group"
#   type        = string
# }

# Azure Active Directory integration
variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster"
  type        = list(string)
}

variable "azure_rbac_enabled" {
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = true
  type        = bool
}

variable "role_based_access_control_enabled" {
  description = "(Optional) Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true. Changing this forces a new resource to be created"
  default     = true
  type        = bool
}

# Application gateway ingress controller integration
variable "ingress_application_gateway" {
  description = "Specifies the Application Gateway ingress controller addon configuration"
  type = object({
    enabled    = bool
    gateway_id = string
  })
  default = {
    enabled    = true
    gateway_id = "/subscriptions/8c58a6e3-68a7-441d-b4a0-4f98dfdfc6f9/resourceGroups/or-test-rg/providers/Microsoft.Network/applicationGateways/or-test-appgw"
  }
}

# Node size
variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard_F2s_v2"
  type        = string
}

# Network profile
variable "network_docker_brifge_cidr" {
  description = "Specifies the Docker bridge cidr"
  default     = "172.17.0.1/16"
  type        = string
}

variable "network_dns_service_ip" {
  description = "Specifies the DNS service IP"
  default     = "10.20.0.10"
  type        = string
}

variable "network_plugin" {
  description = "(Required) Network plugin to use for networking. Currently supported values are azure, kubenet and none. Changing this forces a new resource to be created"
  default     = "kubenet"
  type        = string

  validation {
    condition     = contains(["kubenet", "azure", "none"], var.network_plugin)
    error_message = "The network plugin is invalid"
  }
}

variable "network_policy" {
  description = "(Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico, azure and cilium"
  default     = "calico"
  type        = string

  validation {
    condition     = contains(["calico", "azure", "cilium"], var.network_policy)
    error_message = "The network policy is invalid"
  }
}

variable "outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer. Changing this forces a new resource to be created"
  default     = "userDefinedRouting"
  type        = string

  validation {
    condition     = contains(["loadBalancer", "userDefinedRouting", "managedNATGateway", "userAssignedNATGateway"], var.outbound_type)
    error_message = "The network policy is invalid"
  }
}

# Node pool
variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     = "system"
  type        = string
}

variable "default_node_pool_enable_auto_scaling" {
  description = "Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool?"
  default     = true
  type        = bool
}

variable "default_node_pool_enable_node_public_ip" {
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address?"
  default     = false
  type        = bool
}

variable "default_node_pool_max_count" {
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = 10
  type        = number
}

variable "default_node_pool_min_count" {
  description = "(Optional) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000"
  default     = 1
  type        = number
}

variable "default_node_pool_node_count" {
  description = "(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count"
  default     = 1
  type        = number
}

# Workload identity
variable "workload_identity_enabled" {
  description = "Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false"
  default     = "false"
  type        = string
}

# Managed identities data variables
variable "managed_identities" {
  description = "Specifies the managed identities that should be assigned to the AKS cluster"
  type = object({
    aks_identity_name         = string
    aks_kubelet_identity_name = string
    resource_group_name       = string
  })
  default = {
    aks_identity_name         = "westeurope-cluster"
    aks_kubelet_identity_name = "westeurope-kubelet"
    resource_group_name       = "or-test-rg"
  }
}

# Additional node pools
variable "additional_node_pools_to_create" {
  description = "Speficies whether to create or not to create an additional node pools to the AKS cluster"
  default     = false
  type        = bool
}

variable "nodepools_list" {
  type = list(object({
    nodepool_name         = string
    vm_size               = string
    enable_auto_scaling   = bool
    enable_node_public_ip = bool
    max_count             = number
    min_count             = number
    node_count            = number
  }))
  default = [{
    nodepool_name         = ""
    vm_size               = ""
    enable_auto_scaling   = true
    enable_node_public_ip = false
    max_count             = 3
    min_count             = 1
    node_count            = 1
  }]
}