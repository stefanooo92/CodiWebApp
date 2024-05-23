resource "azurerm_dns_zone" "public_dns_zone" {
  name                = var.domain_name
  resource_group_name = var.rg_name
}

resource "azurerm_dns_a_record" "appgateway_a_record" {
  name                = var.appgateway_a_record_name
  zone_name           = azurerm_dns_zone.public_dns_zone.name
  resource_group_name = var.rg_name
  ttl                 = var.appgateway_a_record_ttl
  records             = var.appgateway_a_record_records
}