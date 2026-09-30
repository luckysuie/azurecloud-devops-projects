resource "azurerm_container_registry" "example" {
  depends_on = [
    azurerm_resource_group.rg,
    azurerm_linux_virtual_machine.ubuntu_vm
  ]
  name                = var.registryname
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "Standard"
  admin_enabled       = true

  identity {
    type = "SystemAssigned"
  }

  tags = { Environment = var.environment }

}