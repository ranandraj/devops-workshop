@echo off
:: Set the PowerShell execution policy to Bypass temporarily and run the PowerShell script
PowerShell -NoProfile -ExecutionPolicy Bypass -File "C:\Path\To\YourScript.ps1"

:: Pause for any output (optional)
pause
