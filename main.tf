module "aks" {
    source = "./azurerm-aks"
    aks_cluster_name = "ortestaks"
    aks_vnet_resource_group_name = "cloud-shell-storage-westeurope"
    aks_vnet_name = "cloud-shell-storage-westeurope-vnet"
    aks_subnet_name = "aks"
    admin_group_object_ids = ["f39fde15-64b2-42b1-8b8b-3ac17666340b"]
}

module "acr" {
  source = "./azurerm-acr"
  acr_name = "ortestacr"
  network_list = [ {
    number         = 1
    vnet           = "cloud-shell-storage-westeurope-vnet"
    subnet         = "aks"
    resource_group = "cloud-shell-storage-westeurope"
  } ]
  ip_list = ["79.176.70.193"]
}