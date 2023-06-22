provider "azurerm" {
  subscription_id = "765266c6-9a23-4638-af32-dd1e32613047"
  features {}
}

resource "azurerm_public_ip" "tp4" {
  name                = "public-ip"
  location            = "francecentral"
  resource_group_name = "ADDA84-CTP"
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "network-tp4" {
}

resource "azurerm_subnet" "tp4" {
  name                 = "internal"
  resource_group_name  = "ADDA84-CTP"
  virtual_network_name = azurerm_virtual_network.network-tp4.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "tp4" {
  name                      = "nic"
  location                  = "francecentral"
  resource_group_name       = "ADDA84-CTP"
  ip_configuration {
    name                          = "config"
    subnet_id                     = azurerm_subnet.tp4.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "tp4" {
  name                = "devops-20190647"
  location            = "francecentral"
  resource_group_name = "ADDA84-CTP"
  size                = "Standard_D2s_v3"
  admin_username      = "devops"
  network_interface_ids = [
    azurerm_network_interface.tp4.id,
  ]

  admin_ssh_key {
    username       = "devops"
    public_key     = tls_private_key.ssh.public_key_openssh
  }

  os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
