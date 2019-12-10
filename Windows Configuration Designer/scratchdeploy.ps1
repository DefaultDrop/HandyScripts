# SYNOPSIS
# Provides all control panel changes as well as starting windows update
param([switch]$Elevated)
function Check-Admin {
$currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
$currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Check-Admin) -eq $false)  {
if ($elevated)
{
# could not elevate, quit
}
 
else {
 
Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}

$folderkey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$uackey = “HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System”
$iepath = "HKCU:\Software\Microsoft\Internet Explorer\Main\"
$iename = "start page"
$ievalue = "https://google.com"
$start_time = Get-Date

#Changes folder options
Set-ItemProperty $folderkey Hidden 1
Set-ItemProperty $folderkey HideFileExt 0
Set-ItemProperty $folderkey AlwaysShowMenus 1
Set-ItemProperty $folderkey HideDrivesWithNoMedia 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value "1"
Stop-Process -processname explorer

#Sets active power plan to High Performance
powercfg /setactive 8C5E7fda-e8bf-4a96-9a85-a6e23a8c635c
#Disables Hibernation
powercfg /hibernate off
#Changes the value of "Turn off the display:"
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 15
#Changes the value of "Put the computer to sleep:"
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 30
#Changes the value of "Turn off hard disk:"
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 60

#Sets IE Home Page
Set-ItemProperty -path $iepath -Name $iename -Value $ievalue

#Install Chocolatey
Set-ExecutionPolicy Unrestricted -Scope Process -Force; iex `
((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Apps
choco install googlechrome -y
choco install firefox -y
choco install jre8 -y
choco install flashplayeractivex -y
choco install 7zip -y 
choco install vlc -y
choco install silverlight -y
choco install adobeair -y
choco install office365business

#Set Time Zone
Set-TimeZone -Name 'Central Standard Time'

#Starts Windows Update
Install-Module PSWindowsUpdate
Get-Command -Module PSWindowsUpdate
Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d
Get-WUInstall –MicrosoftUpdate -Download -Install –AcceptAll –AutoReboot