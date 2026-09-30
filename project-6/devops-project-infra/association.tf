resource "azurerm_network_interface_security_group_association" "nicassociation" {
  network_interface_id      = azurerm_network_interface.nic_card.id
  network_security_group_id = azurerm_network_security_group.vmnsg.id
}