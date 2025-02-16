output "vm_ip" {
  description = "The IP address of the VirtualBox VM"
  value       = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}