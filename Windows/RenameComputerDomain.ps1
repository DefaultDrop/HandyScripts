<#

.SYNOPSIS
A Simple script rename a PC using the format <ClientCode>-<SerialNumber>

.DESCRIPTION
Options:

    -ClientCode       -Short client code string

.EXAMPLE
./RenameComputer.ps1 -ClientCode CTO

.NOTES
The computer will need to be restarted for the change to take effect

Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

Param(
    
    [Parameter(Mandatory = $true)]
    [string]$ClientCode,

    [Parameter(Mandatory = $true)]
    [string]$DomainUser,

    [Parameter(Mandatory = $true)]
    [string]$DomainPass

)

Write-Host "Client Code is $ClientCode"

# Get Domain Credentials
$DomainPassCred = ConvertTo-SecureString $DomainPass -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($DomainPass, $DomainPassCred)

# Get the serial number using WMI
$WMI = get-ciminstance win32_bios
$SerialNumber = $wmi.SerialNumber

# Join the client code and serial number
$NewName = $ClientCode + "-" + $SerialNumber

# Rename the computer
Rename-Computer -NewName $NewName -DomainCredential $Credentials