resource "azurerm_subnet" "subnet" {

  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefix

  dynamic "delegation" {
    for_each = var.service_delegation ? [1] : []

    content {
      name = "delegation-${var.subnet_name}"

      service_delegation {
        name    = "Microsoft.App/environments"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      }
    }

  }

}
