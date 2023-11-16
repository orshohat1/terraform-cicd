locals {
  tags = {
    "Env" = "${var.environment}"
  }

  allowrd_virtual_networks = [for s in data.azurerm_subnet.subnet : {
    action    = "Allow",
    subnet_id = s.id
  }]

  allowed_ip_list = [for ip in var.ip_list : {
    action   = "Allow",
    ip_range = ip
  }]
}