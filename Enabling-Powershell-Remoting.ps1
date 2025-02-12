# Set username and password for local user (Administrator by default)
$UserName = "Administrator" # Ensure you're using the correct user name
$Password = "admin" # Replace with your desired password

# Set the local user password (Administrator account or another user)
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
Set-LocalUser -Name $UserName -Password $SecurePassword
Write-Host "Password for user $UserName has been set."

# Enable Administrator account if disabled (only if needed)
$adminAccount = "Administrator"
$adminStatus = (Get-LocalUser -Name $adminAccount).Enabled
if ($adminStatus -eq $false) {
    Enable-LocalUser -Name $adminAccount
    Write-Host "Administrator account has been enabled."
} else {
    Write-Host "Administrator account is already enabled."
}

# Enable File and Printer Sharing (SMB) through Windows Firewall
New-NetFirewallRule -DisplayName "Allow File and Printer Sharing (SMB)" -Protocol TCP -LocalPort 445 -Action Allow -Profile Any
Write-Host "File and Printer Sharing (SMB) has been enabled in the firewall."

# Allow NetBIOS ports (137, 138, 139) through Windows Firewall
New-NetFirewallRule -DisplayName "Allow NetBIOS" -Protocol TCP -LocalPort 137,138,139 -Action Allow -Profile Any
Write-Host "NetBIOS ports (137, 138, 139) have been enabled in the firewall."

# Allow WinRM (HTTP) and WinRM (HTTPS) through the firewall
New-NetFirewallRule -DisplayName "Allow WinRM (HTTP)" -Protocol TCP -LocalPort 5985 -Action Allow -Profile Any
New-NetFirewallRule -DisplayName "Allow WinRM (HTTPS)" -Protocol TCP -LocalPort 5986 -Action Allow -Profile Any
Write-Host "WinRM (HTTP) and WinRM (HTTPS) have been enabled in the firewall."

# Enable Network Discovery and File Sharing
Set-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-In)" -Enabled True
Set-NetFirewallRule -DisplayName "Network Discovery (NB-Name-In)" -Enabled True
Set-NetFirewallRule -DisplayName "Network Discovery (NB-Datagram-In)" -Enabled True
Set-NetFirewallRule -DisplayName "File and Printer Sharing (NB-Session-In)" -Enabled True
Write-Host "File sharing, network discovery, and remote access have been enabled."

# Set the network profile to Private (recommended for file sharing and discovery)
Set-NetConnectionProfile -InterfaceAlias "Ethernet" -NetworkCategory Private # Change "Wi-Fi" to "Ethernet" if using wired connection
Set-NetConnectionProfile -InterfaceAlias "Wi-Fi" -NetworkCategory Private # Change "Wi-Fi" to "Ethernet" if using wired connection
Write-Host "Network set to Private to allow file sharing and discovery."

# Enable PowerShell Remoting (WinRM) to allow remote administration
Enable-PSRemoting -Force
Write-Host "PowerShell Remoting (WinRM) has been enabled."

# Allow ICMPv4-In and ICMPv6-In (Ping requests)
$ICMPv4Rule = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "ICMPv4-In" }
$ICMPv6Rule = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "ICMPv6-In" }

if ($ICMPv4Rule) {
    Set-NetFirewallRule -DisplayName $ICMPv4Rule.DisplayName -Enabled True
    Write-Host "ICMPv4-In rule enabled."
} else {
    Write-Host "ICMPv4-In rule not found."
}

if ($ICMPv6Rule) {
    Set-NetFirewallRule -DisplayName $ICMPv6Rule.DisplayName -Enabled True
    Write-Host "ICMPv6-In rule enabled."
} else {
    Write-Host "ICMPv6-In rule not found."
}

# Ensure that Windows Defender Firewall is configured correctly for remoting and sharing
$icmp4Rule = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "ICMPv4-In" }
$icmp6Rule = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "ICMPv6-In" }

if ($icmp4Rule) {
    Set-NetFirewallRule -DisplayName $icmp4Rule.DisplayName -Enabled True
    Write-Host "ICMPv4-In rule enabled in the firewall."
}

if ($icmp6Rule) {
    Set-NetFirewallRule -DisplayName $icmp6Rule.DisplayName -Enabled True
    Write-Host "ICMPv6-In rule enabled in the firewall."
}

Write-Host "Setup complete! All necessary firewall rules and user configurations have been applied."