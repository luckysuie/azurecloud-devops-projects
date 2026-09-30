resource "azurerm_public_ip" "vmip" {
  name                = var.publicip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = var.environment
  }
}