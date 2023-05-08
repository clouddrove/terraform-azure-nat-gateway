provider "azurerm" {
  features {}
}

module "resource_group" {
  source  = "clouddrove/resource-group/azure"
  version = "1.0.2"

  name        = "app"
  environment = "example"
  label_order = ["name", "environment"]
  location    = "Canada Central"
}

#Vnet
module "vnet" {
  source  = "clouddrove/virtual-network/azure"
  version = "1.0.4"

  name        = "app"
  environment = "example"
  label_order = ["name", "environment"]

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
  enable_ddos_pp      = false

  #subnet
  subnet_names                  = ["subnet1", "subnet2"]
  subnet_prefixes               = ["10.0.1.0/24", "10.0.2.0/24"]
  disable_bgp_route_propagation = false

  # routes
  enabled_route_table = true
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

module "nat_gateway" {
  depends_on = [module.resource_group, module.vnet]
  source     = "./../"

  create_nat_gateway  = true
  name                = "app"
  environment         = "example"
  label_order         = ["name", "environment"]
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  subnet_ids          = module.vnet.vnet_subnets
}
