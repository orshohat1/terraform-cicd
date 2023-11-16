data "azurerm_subnet" "subnet" {
  for_each             = { for nd in var.network_list : nd.number => nd }
  name                 = each.value.subnet
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.resource_group
}