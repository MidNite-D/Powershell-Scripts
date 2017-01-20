cls
function Download-File ($file)
{
Invoke-Expression ".\curl.exe --progress-bar -O $file"
}

function Extract-MSI ($file,$target)
{
msiexec /a $file /qn TARGETDIR=$target |Out-Null
}

Write-Host "Downloading latest Google Chrome Templates"
Write-Host ""
Download-File "https://dl.google.com/dl/edgedl/chrome/policy/policy_templates.zip"
Write-Host ""
Write-Host "Downloading latest Server 2016 Templates"
Write-Host ""
Download-File "https://download.microsoft.com/download/0/C/0/0C098953-38C6-4DF7-A2B6-DE10A57A1C55/Windows%2010%20and%20Windows%20Server%202016%20ADMX.msi"
Write-Host ""
Write-Host "Extracting MSI's."
Write-Host ""

$name="Windows%2010%20and%20Windows%20Server%202016%20ADMX.msi"
$folder=$name.Trim(".msi")
Write-Host "Extracting $name"
Extract-MSI $name $psscriptroot\$folder

Write-Host "Moving Templates"
#Get-ChildItem $psscriptroot\$folder\PolicyDefinitions -Recurse |Move-Item -Destination c:\windows\sysvol\domain\policies\PolicyDefinitions -Force





