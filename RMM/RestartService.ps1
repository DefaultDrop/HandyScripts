<#

.SYNOPSIS
This script can be run as a job in Datto RMM to restart a service.

.DESCRIPTION
Options:

    -ServiceName       -Name of the service to restart.

.EXAMPLE
./RestartService.ps1 -ServiceName CagService

.NOTES
Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

Restart-Service $env:ServiceName -Force