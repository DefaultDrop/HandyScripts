<#

.SYNOPSIS
This script connects to Exchange Online using the Exchange Online Powershell Module and sets all mailbox permissions to PublishingAuthor.

.DESCRIPTION
Options:
    -o365Login  Office365 login account

.EXAMPLE
./Set-CalendarPermissions.ps1 -o365Login admin@contoso.onmicrosoft.com

.NOTES
Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$o365Login
    )

# Import the Exchange Online Powershell Module
$PSExoPowershellModuleRoot = (Get-ChildItem -Path $env:userprofile -Filter CreateExoPSSession.ps1 -Recurse -ErrorAction SilentlyContinue -Force | Select-Object -Last 1).DirectoryName
$ExoPowershellModule = "Microsoft.Exchange.Management.ExoPowershellModule.dll";
$ModulePath = [System.IO.Path]::Combine($PSExoPowershellModuleRoot, $ExoPowershellModule);
Import-Module $ModulePath;

# Connect to Exchange Online
$Office365PSSession = New-ExoPSSession -UserPrincipalName $o365Login -ConnectionUri "https://outlook.office365.com/powershell-liveid/"
Import-PSSession $Office365PSSession

# Get all mailboxes
$users = Get-Mailbox -Resultsize Unlimited

# Loop through all mailboxes and set calendar permissions
foreach ($user in $users) { 
    Write-Host -ForegroundColor Green "Setting permission for $($user.alias)..." 
    Set-MailboxFolderPermission -Identity "$($user.alias):\calendar" -User Default -AccessRights PublishingAuthor 
    }

# Disconnect the remote session
Write-Host -ForegroundColor Yellow "Disconnecting from the remote session"
Get-PSSession | Remove-PSSession