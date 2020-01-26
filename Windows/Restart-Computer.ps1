<#

.SYNOPSIS
Script to force restart a remote computer

.DESCRIPTION
Options:

    -Computer       -Hostname of the computer that is to be restarted 

.EXAMPLE
./Restart-Computer.ps1 -Computer Computer1

.NOTES
Uses WMI to get the computer name and then calls Win32Shutdown WMI command with the force value in an explicit array.

This will force close open applications!

Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

param(

    [Parameter(Mandatory = $true)]
    [string]$Computer
)

# Restart the computer
Get-WmiObject win32_operatingsystem -ComputerName $Computer | Invoke-WMIMethod -name Win32Shutdown -ArgumentList @(6)