output "appgateway_ip" {
  value = azurerm_public_ip.appgateway_ip.ip_address
}