# PowerShell script to cleanly uninstall Oracle VirtualBox 7.1.6 on Windows 11

# Function to uninstall VirtualBox
function Uninstall-VirtualBox {
    # Use Get-CimInstance to search for Oracle VM VirtualBox
    $virtualboxPackage = Get-CimInstance -ClassName Win32_Product | Where-Object { $_.Name -like "*VirtualBox*" }

    if ($virtualboxPackage) {
        Write-Host "Uninstalling Oracle VM VirtualBox..."
        $virtualboxPackage | ForEach-Object { $_.Uninstall() }
        Write-Host "Oracle VM VirtualBox uninstalled."
    } else {
        Write-Host "Oracle VM VirtualBox not found in installed programs."
    }
}

# Function to delete remaining VirtualBox files and folders
function Clean-VirtualBoxFiles {
    # Define VirtualBox installation directory and user profile directory
    $installDir = "C:\Program Files\Oracle\VirtualBox"
    $userDir = [System.IO.Path]::Combine($env:USERPROFILE, ".VirtualBox")
    
    # Remove the VirtualBox installation folder if it exists
    if (Test-Path $installDir) {
        Write-Host "Removing VirtualBox folder from $installDir..."
        Remove-Item -Recurse -Force $installDir
    }
    
    # Remove the user-specific VirtualBox configuration folder
    if (Test-Path $userDir) {
        Write-Host "Removing user-specific VirtualBox folder from $userDir..."
        Remove-Item -Recurse -Force $userDir
    }
}

# Function to clean registry keys for VirtualBox
function Clean-VirtualBoxRegistry {
    # Define registry paths for VirtualBox
    $registryPaths = @(
        "HKCU:\Software\Oracle\VirtualBox",
        "HKLM:\SOFTWARE\Oracle\VirtualBox",
        "HKLM:\SOFTWARE\WOW6432Node\Oracle\VirtualBox"
    )
    
    foreach ($path in $registryPaths) {
        if (Test-Path $path) {
            Write-Host "Removing registry key from $path..."
            Remove-Item -Recurse -Force $path
        }
    }
}

# Function to clear temporary files
function Clear-TempFiles {
    Write-Host "Clearing temporary files..."
    $tempPath = [System.IO.Path]::GetTempPath()
    Remove-Item -Recurse -Force "$tempPath*" -ErrorAction SilentlyContinue
}

# Function to run the cleanup process
function Clean-UninstallVirtualBox {
    # Uninstall VirtualBox
    Uninstall-VirtualBox
    
    # Clean up remaining files
    Clean-VirtualBoxFiles
    
    # Clean up registry entries
    Clean-VirtualBoxRegistry
    
    # Clear temporary files
    Clear-TempFiles
    
    Write-Host "Reboot your system to complete the cleanup process."
}

# Run the cleanup and uninstallation
Clean-UninstallVirtualBox
