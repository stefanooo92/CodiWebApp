location      = "eastus"
rg_name       = "MADGLIME"
vnet_name     = "aca_vnet"
address_space = ["192.168.0.0/16"]

#subnets
aca_address_prefix    = ["192.168.1.0/27"]
appgtw_address_prefix = ["192.168.2.0/24"]
appgtw_subnet_name    = "appgw-subnet"
aca_subnet_name       = "aca_subnet"

#aca-env
aca_env_name               = "aca-environment"
workload_profile_name      = "wpD4"
workload_profile_type      = "D4"
workload_profile_min_count = 1
workload_profile_max_count = 2

#aca
aca_name      = "aca-app"
revision_mode = "Single"
target_port   = 80
min_replicas  = 3
max_replicas  = 5
container     = "codilime-test-app"
image         = "nginxdemos/hello:0.4"
cpu           = 0.5
memory        = "0.5Gi"

#public-dns
domain_name = "golf13.cloud"

#waf-policy
waf_policy_name = "waf_policy"

custom_rules = [
  {
    name           = "RuleTest1"
    priority       = 1
    rule_type      = "MatchRule"
    match_variable = "RemoteAddr"
    operator       = "IPMatch"
    negation       = false
    match_values   = ["192.168.1.0/24", "10.0.0.0/24"]
    action         = "Block"
  },
  {
    name           = "RuleTest2"
    priority       = 2
    rule_type      = "MatchRule"
    match_variable = "RemoteAddr"
    operator       = "GeoMatch"
    negation       = false
    match_values   = ["RU"]
    action         = "Block"
  }
]

#appgateway
appgateway_name = "appgeteway"
port_http       = 80
port_https      = 443

#nsg
nsg_name = "aca-nsg"
security_rules = [
  {
    name                       = "allow_http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow_https"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "65200-65535"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "DENY_ALL"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]