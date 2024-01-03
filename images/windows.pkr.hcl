packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 2"
    }
  }
}

locals {
}

variable "tenant_id" {
  type    = string
  default = "${env("ARM_TENANT_ID")}"
}

variable "subscription_id" {
  type    = string
  default = "${env("ARM_SUBSCRIPTION_ID")}"
}

variable "client_id" {
  type    = string
  default = "${env("ARM_CLIENT_ID")}"
}

variable "client_secret" {
  type    = string
  default = "${env("ARM_CLIENT_SECRET")}"
}


variable "organization_name" {
  type    = string
  default = "starleasing"
}

variable "build_location" {
  type    = string
  default = "eastus"
}

variable "build_resource_group_name" {
  type    = string
  default = "packer"
}

variable "build_machine_name" {
  type    = string
  default = "packer-build"
}

variable "build_key_vault_name" {
  type    = string
  default = "starleasing-packer"
}

variable "global_resource_group_name" {
  type    = string
  default = "general"
}

source "azure-arm" "windows" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret

  managed_image_resource_group_name = var.build_resource_group_name
  managed_image_name                = "${var.organization_name}-windows-base"

  build_resource_group_name   = var.build_resource_group_name
  build_key_vault_name        = var.build_key_vault_name
  build_key_vault_secret_name = "windows-base-key"
  virtual_network_name        = "${var.organization_name}-${var.global_resource_group_name}-packer-vnet"
  virtual_network_subnet_name = "packer"

  temp_compute_name = var.build_machine_name
  temp_os_disk_name = "windows-base-disk"
  temp_nic_name     = "windows-base-nic"

  # Only needed for VHD
  # storage_account             = "${var.organization_name}images"

  communicator = "winrm"

  spot {
    eviction_policy = "Delete"
    max_price       = "100.00"
  }

  azure_tags = {
    packer = true
  }

  # Also consider: Standard_F2s_v2
  # Standard_D2_v5
  # Standard_B2ms
  vm_size = "Standard_D2_v5"

  image_publisher = "MicrosoftWindowsServer"
  image_offer     = "WindowsServer"
  image_sku       = "2022-datacenter-azure-edition-hotpatch-smalldisk"
  os_type         = "Windows"
  winrm_username  = "packer"
  winrm_insecure  = true
  winrm_timeout   = "5m"
  winrm_use_ssl   = true
}

build {
  sources = ["source.azure-arm.windows"]

  # provisioner "powershell" {
  #   inline = [
  #   ]
  # }
}
