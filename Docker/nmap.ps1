<#

.SYNOPSIS
This script runs a simple nmap scan on the selected host. Handy for a quick portscan from your workstation.

.DESCRIPTION
Options:

    -Target       -DNS host / IP to scan

.EXAMPLE
./nmap.ps1 -Target example.com

.NOTES
Author: Shay Hosking

Docker must already be installed and configured and the uzyexe/nmap imaged pulled.

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$Target
    )

### Run the scan ###
Write-Host "Starting Scan" -ForegroundColor Green
docker run --rm uzyexe/nmap $Target