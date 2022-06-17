terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_network_interface" "main" {
  name                = "Car-Rental-System-NIC"
  resource_group_name = "Deployment"
  location            = "northeurope"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "/subscriptions/885bc0d7-9311-45f6-8db7-ea7481c4f20d/resourceGroups/Deployment/providers/Microsoft.Network/virtualNetworks/Deployment/subnets/default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/885bc0d7-9311-45f6-8db7-ea7481c4f20d/resourceGroups/Deployment/providers/Microsoft.Network/publicIPAddresses/Deployment"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                            = "Car-Rental-System"
  resource_group_name             = "Deployment"
  location                        = "northeurope"
  vm_size                         = "Standard_D2s_v3"
  delete_os_disk_on_termination   = true
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = "CarRentalSys"
    admin_username = "ubuntu"
  }

 os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/ubuntu/.ssh/authorized_keys"
      key_data = file("./public_key")
    }
  }
  
  storage_os_disk  {
    name              = "Car-Rental-Sys-Disk"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    os_type           = "linux"
  }

}

