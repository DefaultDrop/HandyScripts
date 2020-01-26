<#

.SYNOPSIS
This script runs a simple nmap scan on the selected host. Handy for a quick portscan from your workstation.

.DESCRIPTION
Options:

    -Target       -DNS host / IP to scan

.EXAMPLE
./Get-NmapPortsBatch.ps1 -Target example.com

.NOTES
Author: Shay Hosking

Docker must already be installed and configured and the uzyexe/nmap imaged pulled.

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$csv,

    [Parameter(Mandatory = $false)]
    [string]$port
)

$IPs = Import-Csv $csv

if ($port) {
    foreach ($IP in $IPs) {
        Write-Host "Starting Scan on " -ForegroundColor Green -NoNewline; Write-Host $IP.IP -ForegroundColor Red
        docker run --rm uzyexe/nmap -p $port $IP.IP
    }

}
else {
    foreach ($IP in $IPs) {
        Write-Host "Starting Scan on " -ForegroundColor Green -NoNewline; Write-Host $IP.IP -ForegroundColor Red
        docker run --rm uzyexe/nmap $IP.IP
    }
}