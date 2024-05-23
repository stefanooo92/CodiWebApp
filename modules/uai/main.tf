resource "azurerm_user_assigned_identity" "uai" {
  name                = var.user_assigned_identity_name
  resource_group_name = var.rg_name
  location            = var.location
}

resource "azurerm_role_assignment" "identity-appgw-secret-user" {
  role_definition_name = var.azurerm_role_assignment_name
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
  scope                = var.scope
}