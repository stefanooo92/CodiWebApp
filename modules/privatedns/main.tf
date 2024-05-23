resource "azurerm_private_dns_zone" "private_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_a_record" "dns_a_record" {
  name                = var.dns_a_record_name
  zone_name           = azurerm_private_dns_zone.private_zone.name
  resource_group_name = var.rg_name
  ttl                 = var.dns_a_record_ttl
  records             = var.dns_a_record_records
}

resource "azurerm_private_dns_a_record" "wildcard_dns_a_record" {
  name                = var.wildcard_dns_a_record_name
  zone_name           = azurerm_private_dns_zone.private_zone.name
  resource_group_name = var.rg_name
  ttl                 = var.dns_a_record_ttl
  records             = var.wildcard_dns_a_record_records
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_to_vnet" {
  name                  = var.dns_link_name
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.private_zone.name
  virtual_network_id    = var.virtual_network_id
}