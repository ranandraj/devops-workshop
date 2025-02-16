terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "node" {
  count     = 1
  name      = "linux-server"
  image     = "https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20180903.0.0/providers/virtualbox.box"
  cpus      = 2
  memory    = "512 mib"
  

  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }

  provisioner "remote-exec" {
    inline = [
      "cat /etc/os-release" 
    ] 
 }

    connection {
      type        = "ssh"
      user        = "vagrant"   # Default user for Vagrant boxes
      password    = "vagrant"   # Default Vagrant password
      host        = self.network_adapter[0].ipv4_address
      timeout     = "5m"
      private_key = file("C:\\Users\\Anandraj\\.vagrant.d\\insecure_private_key")
    }
  

}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}



