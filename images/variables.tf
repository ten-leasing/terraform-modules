locals {
}

variable "resource_group_name" {
  type = string
}

output "resource_group_name" {
  value = var.resource_group_name
}

variable "location" {
  type = string
}

variable "resource_name_prefix" {
  description = "Name prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(any)
}

variable "vnet_id" {
  type = string
}

variable "vnet_resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}
