variable "user_assigned_identity_name" {
  type    = string
  default = "uai"

}
variable "rg_name" {
  type = string

}

variable "location" {
  type = string

}

variable "azurerm_role_assignment_name" {
  type    = string
  default = "Key Vault Secrets User"

}

variable "scope" {
  type = string

}