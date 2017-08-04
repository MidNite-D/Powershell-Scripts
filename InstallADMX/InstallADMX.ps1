clear-host
function Download-File ($file)
{
Invoke-Expression "$psscriptroot\curl.exe --progress-bar -O $file"
}

Write-Host "Downloading Google Chrome Templates"
Write-Host ""
Download-File "https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip"
Write-Host ""
Write-Host "Downloading Server 2016 Templates"
Write-Host ""
Download-File "https://download.microsoft.com/download/0/C/0/0C098953-38C6-4DF7-A2B6-DE10A57A1C55/Windows%2010%20and%20Windows%20Server%202016%20ADMX.msi"
Write-Host ""
Write-Host "Downloading Office 2016 Templates."
Download-File "https://download.microsoft.com/download/2/E/E/2EEEC938-C014-419D-BB4B-D184871450F1/admintemplates_x64_4549-1000_en-us.exe"

Write-Host "Extracting"
Write-Host ""

$name="Windows%2010%20and%20Windows%20Server%202016%20ADMX.msi"
$folder=$name.Trim(".msi")
Write-Host "Extracting $name"
start-process -filepath "C:\windows\System32\msiexec" -ArgumentList "/a $psscriptroot\$name /qn TARGETDIR=$PSScriptRoot\Server" -NoNewWindow -RedirectStandardOutput

$name="admintemplates_x64_4468-1000_en-us.exe"
$folder=$name.Trim(".exe")
Write-Host "Extracting $name"
start-process -FilePath "$psscriptroot\admintemplates_x64_4549-1000_en-us.exe" -ArgumentList "/quiet /passive /norestart /extract:$PSScriptRoot\Office"

Expand-Archive -Path $PSScriptRoot\policy_templates.zip -DestinationPath $PSScriptRoot\chrome -ErrorAction SilentlyContinue


Write-Host "Moving Templates"
#Get-ChildItem $psscriptroot\$folder\PolicyDefinitions -Recurse |Move-Item -Destination c:\windows\sysvol\domain\policies\PolicyDefinitions -Force
start-sleep 60





