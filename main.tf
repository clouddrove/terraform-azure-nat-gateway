module "labels" {
  source      = "clouddrove/labels/azure"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
}

resource "azurerm_public_ip" "pip" {
  count               = var.create_public_ip ? 1 : 0
  allocation_method   = "Static"
  location            = var.location
  name                = format("%s-NAT-gateway-ip", module.labels.id)
  resource_group_name = var.resource_group_name
  zones               = var.public_ip_zones
  sku                 = "Standard"

  tags = module.labels.tags

}

resource "azurerm_nat_gateway" "natgw" {
  count                   = var.create_nat_gateway ? 1 : 0
  location                = var.location
  name                    = format("%s-NAT-gateway", module.labels.id)
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = var.nat_gateway_idle_timeout

  tags = module.labels.tags

}

resource "azurerm_nat_gateway_public_ip_association" "pip_assoc" {
  count                = var.create_public_ip ? 1 : 0
  nat_gateway_id       = join("", azurerm_nat_gateway.natgw.*.id)
  public_ip_address_id = azurerm_public_ip.pip[0].id
}

resource "azurerm_nat_gateway_public_ip_association" "pip_assoc_custom_ips" {
  for_each             = toset(var.public_ip_ids)
  nat_gateway_id       = join("", azurerm_nat_gateway.natgw.*.id)
  public_ip_address_id = each.value
}

resource "azurerm_subnet_nat_gateway_association" "subnet_assoc" {
  count          = length(var.subnet_ids)
  nat_gateway_id = join("", azurerm_nat_gateway.natgw.*.id)
  subnet_id      = element(var.subnet_ids, count.index)
}
