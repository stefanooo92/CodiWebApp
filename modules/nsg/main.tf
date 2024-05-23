
resource "azurerm_network_security_group" "aca-nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "security_rule" {
    for_each = var.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

}


resource "azurerm_subnet_network_security_group_association" "aca_nsg_association" {
  subnet_id                 = var.nsg_association_subnet_id
  network_security_group_id = azurerm_network_security_group.aca-nsg.id
}