resource "azurerm_service_plan" "app-plan" {
  depends_on          = [azurerm_resource_group.rg]
  name                = "luckyplan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "B1" ## you can put B1 as well as basic
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "webapp" {
  depends_on          = [azurerm_service_plan.app-plan]
  name                = var.webapname
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.app-plan.id

  site_config {
    application_stack {
      dotnet_version = "10.0"
    }
  }
}