<#

.SYNOPSIS
Simple script to find your WAN IP address.

.DESCRIPTION
Options:

.EXAMPLE
./FindWANIP.ps1

.NOTES
All credit to: 
https://gallery.technet.microsoft.com/scriptcenter/Get-ExternalPublic-IP-c1b601bb

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

# API request to ipinfo.io
$ipinfo = Invoke-RestMethod http://ipinfo.io/json 

# Write retuned values
Write-Host "IP: " -NoNewline; Write-Host -ForegroundColor Red $ipinfo.ip 
Write-Host "Hostname:" $ipinfo.hostname 
Write-Host "City:" $ipinfo.city 
Write-Host "Region:" $ipinfo.region 
Write-Host "Country:" $ipinfo.country 
Write-Host "Location:" $ipinfo.loc 
Write-Host "Organisation:" $ipinfo.org