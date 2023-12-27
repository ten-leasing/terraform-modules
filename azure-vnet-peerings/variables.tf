variable "vnet1_resource_group_name" {
  type = string
}

variable "vnet2_resource_group_name" {
  type = string
}

variable "vnet1_name" {
  type = string
}

variable "vnet2_name" {
  type = string
}

variable "vnet1_id" {
  type = string
}

variable "vnet2_id" {
  type = string
}

variable "vnet1_address_space" {
  type = list(string)
}

variable "vnet2_address_space" {
  type = list(string)
}

variable "vnet1_allow_vnet2_network_access" {
  type    = bool
  default = true
}

variable "vnet2_allow_vnet1_network_access" {
  type    = bool
  default = true
}

variable "vnet1_allow_vnet2_gateway_transit" {
  type    = bool
  default = true
}

variable "vnet2_allow_vnet1_gateway_transit" {
  type    = bool
  default = false
}

variable "vnet1_allow_vnet2_forwarded_traffic" {
  type    = bool
  default = true
}

variable "vnet2_allow_vnet1_forwarded_traffic" {
  type    = bool
  default = true
}

variable "vnet1_use_vnet2_remote_gateway" {
  type    = bool
  default = false
}

variable "vnet2_use_vnet1_remote_gateway" {
  type    = bool
  default = true
}
