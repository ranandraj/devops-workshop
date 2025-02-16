resource "virtualbox_vm" "node" {
  count     = 1
  name      = var.vm_name
  image     = var.vm_image
  cpus      = var.vm_cpus
  memory    = var.vm_memory

  network_adapter {
    type           = "hostonly"
    host_interface = var.host_interface
  }

  provisioner "remote-exec" {
    inline = [
      "cat /etc/os-release"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.ssh_user
    password    = var.ssh_password
    host        = self.network_adapter[0].ipv4_address
    timeout     = "5m"
    private_key = file(var.ssh_private_key)
  }
}