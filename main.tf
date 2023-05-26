terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-github-actions-state"
    storage_account_name = "aadeshterraform"
    container_name       = "tfstatefile"
    key                  = "tfstatefile.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "aadeshrg" {
  name     = "aadeshrg"
  location = "eastus2"
}

#Create Virtual Network
resource "azurerm_virtual_network" "aadeshvnet" {
  name                = "aadeshvnet"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.aadeshrg.name
}

# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.aadeshrg.name
  virtual_network_name = azurerm_virtual_network.aadeshvnet.name
  address_prefix       = "192.168.0.0/24"
}
