locals {
  computer_name = random_pet.computer_name.id
}

output "vm_name" {
  value = local.computer_name
}

variable "computer_name_prefix" {
  type    = string
  default = "vm"
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B4ms"
}

variable "storage_disk_size" {
  type    = number
  default = 32
}

variable "timezone" {
  type    = string
  default = "US Eastern Standard Time"
}

variable "license_type" {
  type    = string
  default = "None"
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition-hotpatch-smalldisk"
    version   = "latest"
  }
}

resource "random_pet" "computer_name" {
  length = 1
  prefix = var.computer_name_prefix
}

resource "random_pet" "admin_username" { length = 1 }

resource "random_password" "admin_password" { length = 16 }

output "vm_credentials" {
  value = {
    (random_pet.admin_username.id) : random_password.admin_password.result
  }
}

resource "azurerm_windows_virtual_machine" "self" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})
  name                = var.vm_name

  size                       = var.vm_size
  admin_username             = random_pet.admin_username.id
  admin_password             = random_password.admin_password.result
  computer_name              = local.computer_name
  network_interface_ids      = [azurerm_network_interface.vm.id]
  allow_extension_operations = true
  enable_automatic_updates   = true
  patch_mode                 = "AutomaticByPlatform"
  reboot_setting             = "IfRequired"
  timezone                   = var.timezone
  secure_boot_enabled        = false
  vtpm_enabled               = false
  provision_vm_agent         = true
  license_type               = var.license_type
  # hotpatching_enabled        = true

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    name                 = "${var.resource_name_prefix}-os-disk"
    caching              = "ReadOnly"
    storage_account_type = "Standard_LRS"

    diff_disk_settings {
      option    = "Local"
      placement = "ResourceDisk"
    }

    disk_size_gb = var.storage_disk_size
  }

  additional_capabilities {
    ultra_ssd_enabled = false
  }

  lifecycle {
    replace_triggered_by = [azurerm_network_interface.vm]
  }
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.self.id
}
