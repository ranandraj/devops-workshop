terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# Declare the variable for the VM name
variable "vm_name" {
  description = "The name of the VirtualBox VM"
  type        = string
  default     = "li12322"
}

# Declare the variable for userprofile path to collect ssh key path to display in output
variable "USERPROFILE" {
  default = "%USERPROFILE%"
}

# Resource to create the VM in VirtualBox
resource "virtualbox_vm" "node" {
  count     = 1
  name      = var.vm_name   # Use the variable for the VM name
  image     = "./virtualbox.box"
  cpus      = 2
  memory    = "512 mib"
  
  # Network configuration
  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

module "vm_module" {
  source     = "./vm_module"
  depends_on = [virtualbox_vm.node]

  # Pass the VM name variable to the child module
  nodename = var.vm_name
}

