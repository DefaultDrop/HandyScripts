<#
.Synopsis
 Office 2016 installation sample script
.DESCRIPTION
 Extract the ZIP and run the Office setup.exe with the configuration file as a parameter
#>
[CmdletBinding()]
[Alias()]
[OutputType([int])]

Param
(
 [Parameter(Mandatory=$false,
 ValueFromPipelineByPropertyName=$true,
 Position=0)]
 $Log = "$env:windir\debug\Start-ProvisioningCommands.log"
)

Begin
{
 <#
 # Start logging
 #>
 Start-Transcript -Path $Log -Force -ErrorAction SilentlyContinue

<#
 # Extract the ZIP
 #> 
 $Archives = Get-ChildItem -Path $PSScriptRoot -Filter *.zip | Select-Object -Property FullName
 ForEach-Object -InputObject $Archives -Process { Expand-Archive -Path $_.FullName -DestinationPath "$env:TEMP" -Force }
}

Process
{
 <#
 # Office 2016 installation
 #> 
 $WorkingDirectory = "$env:TEMP\O365"
 $Configuration = Get-ChildItem -Path $WorkingDirectory -Filter *.xml | Select-Object -Property FullName
 [XML]$XML = Get-Content -Path $Configuration.FullName
 $XML.Configuration.Add.SourcePath = $WorkingDirectory
 $XML.Save($Configuration.FullName)

 # Run Office 2016 setup.exe
 Start-Process -FilePath "$WorkingDirectory\Setup.exe" -ArgumentList ('/Configure "{0}"' -f $Configuration.FullName) -WorkingDirectory $WorkingDirectory -Wait -WindowStyle Hidden

 # If you want to remove the extracted Office source, uncomment below
 # Remove-Item -Path $WorkingDirectory -Force
}
End
{
 <#
 # Stop logging
 #> 
 Stop-Transcript -ErrorAction SilentlyContinue
}