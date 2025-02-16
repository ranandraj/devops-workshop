variable "vm_name" {
  description = "Name of the VirtualBox VM"
  type        = string
  default     = "linux-server"
}

variable "vm_cpus" {
  description = "Number of CPUs for the VM"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory allocated to the VM"
  type        = string
  default     = "512 mib"
}

variable "vm_image" {
  description = "URL of the Vagrant box"
  type        = string
  default     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
}

variable "host_interface" {
  description = "Host-only network adapter"
  type        = string
  default     = "VirtualBox Host-Only Ethernet Adapter"
}

variable "ssh_user" {
  description = "SSH Username"
  type        = string
  default     = "vagrant"
}

variable "ssh_password" {
  description = "SSH Password"
  type        = string
  default     = "vagrant"
}

variable "ssh_private_key" {
  description = "Path to the private key file"
  type        = string
  default     = "C:\\Users\\Anandraj\\.vagrant.d\\insecure_private_key"
}
