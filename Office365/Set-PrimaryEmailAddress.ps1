<#

.SYNOPSIS
Script to update primary email address of a user in Exchange Online.

.DESCRIPTION
Options:

    -o365User       -User to update. In format of room@yourdomain.com.
    -NewEmail       -New primary email address

.EXAMPLE
./Set-PrimaryEmailAddress.ps1 -o365User susan.g@contoso.com -NewEmail susan@contoso.com

.NOTES
Author: Shay Hosking


.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [Parameter(Mandatory = $true)]
    [string]$O365User,

    [Parameter(Mandatory = $true)]
    [string]$NewEmail
    )

### Connect to Exchange Online ###
Write-Host "Please enter your Office 365 User/Password" -ForegroundColor Yellow
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

try {
### Update Primary Email Address ###
Write-Host "Updating Primary Email" -ForegroundColor Green
Set-Mailbox -Identity $O365User -WindowsEmailAddress $NewEmail -ErrorAction Stop
}
catch {
    $ErrorMessage = $_.Exception.Message
    Write-Host "Failed" -ForegroundColor Red
    Write-Host $ErrorMessage -ForegroundColor Red
}
