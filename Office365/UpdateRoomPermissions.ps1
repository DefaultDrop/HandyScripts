<#

.SYNOPSIS
This script updates permissions on a room calendar to display meeting detail for all users.

.DESCRIPTION
Options:

    -Room       -Room to update permissions on. In format of room@yourdomain.com.

.EXAMPLE
./UpdateRoomPermissions.ps1 -Room meetingroom@contoso.com

.NOTES
Author: Shay Hosking

Taken from blog article: 
https://jasoncoltrin.com/2017/06/21/office365-outlook-room-calendar-not-showing-details-displays-busy-only-fix-when-set-mailboxfolderpermission-does-not-resolve/

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$Room
    )

### Connect to Exchange Online ###
Write-Host "Please enter your Office 365 User/Password" -ForegroundColor Yellow
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

try {
### Update Room Calendar Permissions ###
Write-Host "Updating Room Calendar Permissions" -ForegroundColor Green
Set-MailboxFolderPermission -Identity "${Room}:\Calendar" -User default -AccessRights PublishingAuthor -ErrorAction Stop
}
catch {
    $ErrorMessage = $_.Exception.Message
    Write-Host "Failed" -ForegroundColor Red
    Write-Host $ErrorMessage -ForegroundColor Red
}
