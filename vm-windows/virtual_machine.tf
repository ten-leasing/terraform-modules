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

variable "key_vault_id" {
  type = string
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
  computer_name              = random_pet.computer_name.id
  network_interface_ids      = [azurerm_network_interface.vm.id]
  allow_extension_operations = true
  enable_automatic_updates   = true
  # hotpatching_enabled        = true
  patch_mode          = "AutomaticByPlatform"
  reboot_setting      = "IfRequired"
  timezone            = var.timezone
  secure_boot_enabled = false
  vtpm_enabled        = false
  provision_vm_agent  = true
  license_type        = var.license_type

  winrm_listener {
    protocol        = "Https"
    certificate_url = azurerm_key_vault_certificate.vm.secret_id
  }

  identity {
    type = "SystemAssigned"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition-hotpatch-smalldisk"
    version   = "latest"
  }

  # Disabling because boot_diagnostics is not compatible with our global storage account
  # And we're not creating an entirely different storage account just for a VM
  # boot_diagnostics {
  #   storage_account_uri = null
  # }

  secret {
    key_vault_id = var.key_vault_id
    certificate {
      url   = azurerm_key_vault_certificate.vm.secret_id
      store = var.resource_name_prefix
    }
  }

  # NOTE Not sure if needed - what would the content need to be?
  # additional_unattend_config {
  #   setting_name = "FirstLogonCommands" # Or 'AutoLogon'
  #   content      = ""
  # }

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
}

output "vm_id" {
  value = azurerm_windows_virtual_machine.self.id
}
