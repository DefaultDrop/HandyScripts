<#

.SYNOPSIS
A Simple script to tail a file in PowerShell

.DESCRIPTION
Options:

    -FilePath           - Path to the file to tail

.EXAMPLE
./PS-Tail.ps1 - FilePath "C:\Path\To\File.txt"

.NOTES
Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

Param(
    
    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

# Tail the file
Get-Content $FilePath -Wait
