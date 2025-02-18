param (
    [string]$vmName
)

Write-Host "Configuring VirtualBox for VM: $vmName"


Write-Host "Sleeping for 10 seconds..."
Start-Sleep -Seconds 10

Write-Host "Shutting down the VM gracefully..."
VBoxManage controlvm $vmName acpipowerbutton
Start-Sleep -Seconds 40

Write-Host "Disabling NIC1..."
VBoxManage modifyvm $vmName --nic1 none
Start-Sleep -Seconds 10

Write-Host "Changing NIC1 to NAT..."
VBoxManage modifyvm $vmName --nic1 nat
Start-Sleep -Seconds 10

Write-Host "Configuring NIC2 as host-only adapter..."
VBoxManage modifyvm $vmName --nic2 hostonly --hostonlyadapter2 'VirtualBox Host-Only Ethernet Adapter'
Start-Sleep -Seconds 10

Write-Host "Starting VM in headless mode..."
VBoxManage startvm $vmName --type headless
Start-Sleep -Seconds 60

Write-Host "Running dhclient on the VM..."
VBoxManage guestcontrol $vmName run --exe "/bin/bash" --username "vagrant" --password "vagrant" --wait-stdout -- -c "sudo dhclient"

Write-Host "Running dhclient on the VM..."


$adapter0 = "/VirtualBox/GuestInfo/Net/0/V4/IP"
$adapter1 = "/VirtualBox/GuestInfo/Net/1/V4/IP"

# Retrieve the IP address using VBoxManage
$ipAddress0 = VBoxManage guestproperty get $vmName $adapter0
$ipAddress1 = VBoxManage guestproperty get $vmName $adapter1

# Clean up the output to extract only the IP address
$ipAddress0 = $ipAddress0 -replace "Value:", "" -replace "\s", ""
$ipAddress1 = $ipAddress1 -replace "Value:", "" -replace "\s", ""

# Get the USERPROFILE environment variable
$userProfile = $env:USERPROFILE

# Construct the SSH command
$sshCommand0 = "ssh -i $userProfile\.vagrant.d\insecure_private_key vagrant@$ipAddress0"
$sshCommand1 = "ssh -i $userProfile\.vagrant.d\insecure_private_key vagrant@$ipAddress1"
# Output the SSH command
Write-Output $sshCommand0
Write-Output $sshCommand1
Write-Host "Script execution completed."
