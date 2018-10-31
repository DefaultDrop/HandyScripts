<#

.SYNOPSIS
This script installs Windows Management Framework (WMF) 5.1

.DESCRIPTION
Options:

.EXAMPLE
./Install-WMF5-1.ps1

.NOTES
WMF 5.1 includes PowerShell version 5.1, this script is handy for running scripts that require 5.1 at minumum.
Server 2016 and Windows 10 include 5.1 in the box.

Installation files for different operating systems are available at the URL below:
https://docs.microsoft.com/en-us/powershell/wmf/5.1/install-configure

MSU files are expected to be in the same working directory as this script.

Note that Windows 7 SP1 and Server 2008 R2 require .NET Framework 4.5.2 to be installed to install WMF 5.1.

Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

$osInfo = Get-CimInstance Win32_OperatingSystem | Select-Object Caption

# Server 2012 R2
if ((@($osInfo.Caption) -like '*2012 R2*').Count -gt 0) {
    Write-Host "2012 R2"
    wusa.exe Win8.1AndW2K12R2-KB3191564-x64.msu /quiet
} 

# Server 2008 R2
if ((@($osInfo.Caption) -like '*2008 R2*').Count -gt 0) {
    Write-Host "2008 R2"
    wusa.exe Win7AndW2K8R2-KB3191566-x64.msu /quiet
}

# Windows 7
if ((@($osInfo.Caption) -like '*Windows 7*').Count -gt 0) {
    Write-Host "2008 R2"
    wusa.exe Win7AndW2K8R2-KB3191566-x64.msu /quiet
}

# Windows 8.1
if ((@($osInfo.Caption) -like '*Windows 8*').Count -gt 0) {
    Write-Host "2008 R2"
    wusa.exe Win8.1AndW2K12R2-KB3191564-x64.msu /quiet
}