resource "azurerm_network_interface" "nic_card" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = tolist(azurerm_virtual_network.vnet.subnet)[0].id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.vmip.id
  }
}