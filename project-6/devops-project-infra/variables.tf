variable "resource_group" {
  description = "please enter resource group name"
  type        = string
}

variable "location" {
  description = "Please enter valid Location"
  type        = string
}

variable "environment" {
  description = "Please enter Environment"
  type        = string
}

variable "vnet_name" {
  description = "please enter virtual network name"
  type        = string
}

variable "subnet_name" {
  description = "please enter subnet name"
  type        = string
}

variable "nsg" {
  description = "Please enter Network security group name"
  type        = string
}

variable "publicip_name" {
  description = "Please enter public IP name"
  type        = string
}

variable "nic_name" {
  description = "please enter NIC card name"
  type        = string
}

variable "vm_name" {
  description = "please enter Virtual machine Name"
  type        = string
}

variable "registryname" {
  description = "Please enter Container Registry name"
  type        = string
}

variable "webapname" {
  description = "please enter webapp name"
  type        = string
}