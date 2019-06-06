##################################################
# Script to update primary email address in
# Exchange Online
#
# Usage: PS-ExchangeOnlineUpdatePriEmail 
#   -O365User "UserToUpdate@yourdomainname.com"                      
#   -NewEmail "NewEmail@yourdomain.com"                       
#
# https://github.com/DefaultDrop/Scripts
#
##################################################

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
