<#

.SYNOPSIS
A Simple script start or stop a service

.DESCRIPTION
Options:

    -Start       -Start the service
    -Stop        -Stop the service
    -Service     -The service to alter

.EXAMPLE
./Set-ServiceState.ps1 -Start -Service ServiceName

.NOTES
Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

if ($Start) {
    Write-Host "Starting Service"
    net start $Service
}

if ($Stop) {
    Write-Host "Stopping Service"
    net stop $Service
}
