variable "nodename" {
  description = "The name of the VirtualBox VM"
  type        = string
}

resource "null_resource" "vboxcli" {
  provisioner "local-exec" {
    command = ".'${path.module}\\add-nat-adapter.ps1' -vmName '${var.nodename}'"
    interpreter = ["PowerShell", "-Command"]
  }
}
