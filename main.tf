terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.102.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}


#Resource group creation
module "rg" {
  source   = "./modules/rg"
  rg_name  = var.rg_name
  location = var.location
}

#Vnet creation
module "vnet" {
  source        = "./modules/vnet"
  vnet_name     = var.vnet_name
  rg_name       = module.rg.rg_name
  location      = var.location
  address_space = var.address_space
}

#Azure container apps subnet creation
module "aca_subnet" {
  source             = "./modules/subnet"
  rg_name            = module.rg.rg_name
  vnet_name          = module.vnet.vnet_name
  subnet_name        = var.aca_subnet_name
  address_prefix     = var.aca_address_prefix
  service_delegation = true
}

#App gateway creation
module "appgtw_subnet" {
  source             = "./modules/subnet"
  rg_name            = module.rg.rg_name
  vnet_name          = module.vnet.vnet_name
  subnet_name        = var.appgtw_subnet_name
  address_prefix     = var.appgtw_address_prefix
  service_delegation = false
}

#Azure container apps environment creation
module "aca_env" {
  source                     = "./modules/aca_env"
  aca_env_name               = var.aca_env_name
  location                   = var.location
  rg_name                    = module.rg.rg_name
  workload_profile_name      = var.workload_profile_name
  workload_profile_type      = var.workload_profile_type
  workload_profile_min_count = var.workload_profile_min_count
  workload_profile_max_count = var.workload_profile_max_count
  subnet_id                  = module.aca_subnet.subnet_id

}

#Azure container apps creation
module "aca" {
  source                = "./modules/aca"
  aca_name              = var.aca_name
  aca_env_id            = module.aca_env.aca_env_id
  rg_name               = module.rg.rg_name
  workload_profile_name = var.workload_profile_name
  revision_mode         = var.revision_mode
  target_port           = var.target_port
  min_replicas          = var.min_replicas
  max_replicas          = var.max_replicas
  container             = var.container
  image                 = var.image
  cpu                   = var.cpu
  memory                = var.memory

}

#Private dns zone creation
module "privatedns" {
  source                        = "./modules/privatedns"
  private_dns_zone_name         = module.aca_env.aca_env_default_domain
  rg_name                       = module.rg.rg_name
  dns_a_record_records          = [module.aca_env.aca_env_static_ip]
  wildcard_dns_a_record_records = [module.aca_env.aca_env_static_ip]
  virtual_network_id            = module.vnet.vnet_id

}

#Public dns zone creation
module "publicdns" {
  source                      = "./modules/publicdns"
  domain_name                 = var.domain_name
  rg_name                     = module.rg.rg_name
  appgateway_a_record_records = [module.appgtw.appgateway_ip]
}

#Keyvault and SSL certifiacate creation
module "keyvault" {
  source      = "./modules/keyvault"
  domain_name = var.domain_name
  location    = var.location
  rg_name     = module.rg.rg_name
}

#User assigned identity creation
module "uai" {
  source   = "./modules/uai"
  rg_name  = module.rg.rg_name
  location = var.location
  scope    = module.keyvault.keyvault_id

}

#WAF policy creation
module "waf" {
  source          = "./modules/waf"
  rg_name         = module.rg.rg_name
  location        = var.location
  waf_policy_name = var.waf_policy_name
  custom_rules    = var.custom_rules

}

#Application gateway creation
module "appgtw" {
  source                    = "./modules/appgtw"
  rg_name                   = module.rg.rg_name
  location                  = var.location
  appgateway_name           = var.appgateway_name
  identity_ids              = [module.uai.uai_id]
  ssl_certificate_name      = var.domain_name
  key_vault_secret_id       = module.keyvault.keyvault_certificate_secret_id
  gateway_ip_subnet_id      = module.appgtw_subnet.subnet_id
  port_http                 = var.port_http
  port_https                = var.port_https
  backend_address_pool_fqdn = [module.aca.aca_latest_revision_fqdn]
  domain_name               = var.domain_name
  firewall_policy_id        = module.waf.firewall_policy_id

}

#Network security group creation
module "nsg" {
  source                    = "./modules/nsg"
  nsg_name                  = var.nsg_name
  rg_name                   = module.rg.rg_name
  location                  = var.location
  security_rules            = var.security_rules
  nsg_association_subnet_id = module.appgtw_subnet.subnet_id

}