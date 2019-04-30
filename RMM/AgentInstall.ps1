<#
.SYNOPSIS
Downloads and installs AEM Agent (SiteName).
Intended to run via Intune.
#>

# If CentraStage is already installed, skip download and install
If (!(Get-WmiObject -Class Win32_Product | Where-Object Name -Like "CentraStage*")) {

    # CentrStage download source
    $Url = "https://syrah.centrastage.net/csm/profile/downloadAgent/8b36c212-a9ef-478c-8ca5-bb0faddb70c3"
    $Target = "$env:systemRoot\Temp\AgentSetup_Eaglecrest.exe"
    
    # Delete the target if it exists, so that we don't have issues
    If (Test-Path $Target) { Remove-Item -Path $Target -Force -ErrorAction SilentlyContinue }
    
    # Download CentraStage Agent locally
    Start-BitsTransfer -Source $Url -Destination $Target
    
    # Install CentraStage Agent
    If (Test-Path $Target) { Start-Process -FilePath $Target -ArgumentList "/quiet" -Wait }
}