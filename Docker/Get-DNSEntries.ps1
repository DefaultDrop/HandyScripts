<#

.SYNOPSIS
This script runs a simple dig command to find A, MX and TXT records for a given domain name.

.DESCRIPTION
Options:

    -Target       -Domain name to query

.EXAMPLE
./Get-DNSEnties.ps1 -Target example.com

.NOTES
Author: Shay Hosking

Docker must already be installed and configured and the tutum/dnsutils imaged pulled.

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$Target
    )

### Run the scan ###
Write-Host "Getting DNS entries for $Target" -ForegroundColor Green

Write-Host "A " -ForegroundColor Red
docker run -it tutum/dnsutils dig $Target A +noall +short

Write-Host "`nMX " -ForegroundColor Red
docker run -it tutum/dnsutils dig $Target MX +noall +short

Write-Host "`nTXT " -ForegroundColor Red
docker run -it tutum/dnsutils dig $Target TXT +noall +short