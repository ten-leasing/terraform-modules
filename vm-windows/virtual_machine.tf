locals {
  admin_username = var.admin_username == null ? one(random_pet.admin_username).id : var.admin_username
}

variable "admin_username" {
  type    = string
  default = null
}

variable "vm_name" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B4ms"
}

variable "availability_zone" {
  type     = string
  nullable = true
  default  = null
}

variable "computer_name" {
  type = string
}

variable "custom_data" {
  type     = string
  nullable = true
  default  = null
}

variable "user_data" {
  type     = string
  nullable = true
  default  = null
}

variable "encryption_at_host_enabled" {
  type    = bool
  default = false
}

variable "ultra_ssd_enabled" {
  type    = bool
  default = false
}

variable "enable_automatic_updates" {
  type    = bool
  default = true
}

variable "hotpatching_enabled" {
  type    = bool
  default = true
}

variable "patch_assessment_mode" {
  type    = string
  default = "AutomaticByPlatform"
  validation {
    condition     = contains(["AutomaticByPlatform", "ImageDefault"], var.patch_assessment_mode)
    error_message = "Possible values are 'AutomaticByPlatform' or 'ImageDefault'"
  }
}

variable "patch_mode" {
  type    = string
  default = "AutomaticByPlatform"
  validation {
    condition     = contains(["Manual", "AutomaticByOS", "AutomaticByPlatform"], var.patch_mode)
    error_message = "Possible values are 'Manual', 'AutomaticByOS' and 'AutomaticByPlatform'"
  }
}

variable "reboot_setting" {
  type     = string
  nullable = true
  default  = "IfRequired"
  validation {
    condition     = var.reboot_setting == null || contains(["Always", "IfRequired", "Never"], coalesce(var.reboot_setting, 0))
    error_message = "Possible values are 'Always', 'IfRequired' and 'Never'"
  }
}

variable "disk_controller_type" {
  type     = string
  nullable = true
  default  = null
  validation {
    condition     = var.disk_controller_type == null || contains(["SCSI", "NVMe"], coalesce(var.disk_controller_type, 0))
    error_message = "Possible values are 'SCSI' or 'NVMe'"
  }
}

variable "os_storage_disk_size" {
  type    = number
  default = 32
}

variable "os_storage_disk_caching" {
  type    = string
  default = "ReadOnly"
  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_storage_disk_caching)
    error_message = "Possible values are 'None', 'ReadOnly', and 'ReadWrite'"
  }
}

variable "os_storage_disk_account_type" {
  type    = string
  default = "Standard_LRS"
  validation {
    condition = contains(
      ["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"],
      var.os_storage_disk_account_type
    )
    error_message = "Possible values are 'Standard_LRS', 'StandardSSD_LRS', 'Premium_LRS', 'StandardSSD_ZRS' and 'Premium_ZRS'"
  }
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

resource "random_pet" "admin_username" {
  count  = var.admin_username == null ? 1 : 0
  length = 1
}

resource "random_password" "admin_password" { length = 16 }

output "vm_credentials" {
  sensitive = false
  value     = { (local.admin_username) : sensitive(random_password.admin_password.result) }
}

resource "azurerm_windows_virtual_machine" "self" {
  provider            = azurerm.current
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})
  name                = var.vm_name

  size                              = var.vm_size
  admin_username                    = local.admin_username
  admin_password                    = random_password.admin_password.result
  custom_data                       = var.custom_data
  user_data                         = var.user_data
  computer_name                     = upper(var.computer_name)
  network_interface_ids             = [azurerm_network_interface.vm.id]
  allow_extension_operations        = true
  timezone                          = var.timezone
  secure_boot_enabled               = false
  vtpm_enabled                      = false
  provision_vm_agent                = true
  vm_agent_platform_updates_enabled = true
  license_type                      = var.license_type
  enable_automatic_updates          = var.enable_automatic_updates
  patch_assessment_mode             = var.patch_assessment_mode
  patch_mode                        = var.patch_mode
  reboot_setting                    = var.reboot_setting
  hotpatching_enabled               = var.hotpatching_enabled
  zone                              = var.availability_zone
  encryption_at_host_enabled        = var.encryption_at_host_enabled
  disk_controller_type              = var.disk_controller_type

  identity {
    type         = "SystemAssigned"
    identity_ids = []
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  os_disk {
    name                 = "${var.vm_name}-os-disk"
    caching              = var.os_storage_disk_caching
    storage_account_type = var.os_storage_disk_account_type
    disk_size_gb         = var.os_storage_disk_size

    # Likely won't use VM Sizes that include support for ephemeral disks
    # diff_disk_settings {
    #   option    = "Local"
    #   placement = "ResourceDisk"
    # }
  }

  additional_capabilities {
    ultra_ssd_enabled = var.ultra_ssd_enabled
  }

  lifecycle {
    # replace_triggered_by = [azurerm_network_interface.vm]
  }
}

output "vm_id" { value = azurerm_windows_virtual_machine.self.id }
output "vm_name" { value = azurerm_windows_virtual_machine.self.name }
output "vm_availability_zone" { value = azurerm_windows_virtual_machine.self.zone }
output "vm_system_assigned_identity_principal_id" { value = one(azurerm_windows_virtual_machine.self.identity).principal_id }
output "computer_name" { value = azurerm_windows_virtual_machine.self.computer_name }
