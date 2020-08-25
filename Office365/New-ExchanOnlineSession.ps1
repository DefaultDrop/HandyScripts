<#

.SYNOPSIS
This script connects to exchange online.

.DESCRIPTION
Options:
    -mfa  Switch if MFA is required on the user/tenant

.EXAMPLE
./New-ExchanOnlineSession.ps1 -mfa

.NOTES
Author: Shay Hosking

.LINK
https://github.com/DefaultDrop/HandyScripts

#>

### User Paramaters ###
param(  
    [switch]$mfa = $false
)

if ($mfa) {
    $MFAExchangeModule = ((Get-ChildItem -Path $($env:LOCALAPPDATA + "\Apps\2.0\") -Filter CreateExoPSSession.ps1 -Recurse ).FullName | Select-Object -Last 1) 
    If ($null -eq $MFAExchangeModule) {
        Write-Host "Please install Exchange Online MFA Module. See the follow link:"-ForegroundColor Yellow 
        Write-Host "https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell" -ForegroundColor Yellow
    }
    else {
        Write-Host "Exchange Online Powershell module found" -ForegroundColor Green

        $o365upn = Read-Host "Please input your UPN for o365"

        # Import the Exchange Online Powershell Module
        $PSExoPowershellModuleRoot = (Get-ChildItem -Path $env:userprofile -Filter CreateExoPSSession.ps1 -Recurse -ErrorAction SilentlyContinue -Force | Select-Object -Last 1).DirectoryName
        $ExoPowershellModule = "Microsoft.Exchange.Management.ExoPowershellModule.dll";
        $ModulePath = [System.IO.Path]::Combine($PSExoPowershellModuleRoot, $ExoPowershellModule);
        Import-Module $ModulePath;

        # Connect to Exchange Online
        $Office365PSSession = New-ExoPSSession -UserPrincipalName $o365upn -ConnectionUri "https://outlook.office365.com/powershell-liveid/"
        Import-PSSession $Office365PSSession
    }     
}
else {
    ### Connect to Exchange Online ###
    Write-Host "Please enter your Office 365 User/Password" -ForegroundColor Yellow
    $UserCredential = Get-Credential
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
    Import-PSSession $Session        
}