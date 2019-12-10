#.\Provision-o365.ps1
# Invoke-Expression -Command "$PSScriptRoot\test.ps1"
# Write-Host "Path:" $PSScriptRoot

Write-Host "Installing Office 365"
.\Provision-o365.ps1

Write-Host "Installing Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Write-Host "Installing Apps"

choco install googlechrome


Copy-Item "Office 365 Login.url" -Destination "C:\Users\Public\Desktop"



