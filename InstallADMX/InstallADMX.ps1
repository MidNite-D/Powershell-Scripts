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
Write-Host "Downloading latest Server 2012R2 / Windows 8.1 Templates"
Write-Host ""
Download-File "https://download.microsoft.com/download/7/F/5/7F5E839D-8254-46D6-B9E0-F1B555AFA48B/Windows8.1-Server2012R2ADMX-RTM.msi"
Write-Host ""
Write-Host "Downloading latest Windows 10 Templates"
Write-Host ""
Download-File "https://download.microsoft.com/download/2/E/3/2E3A1E42-8F50-4396-9E7E-76209EA4F429/Windows10_Version_1511_ADMX.msi"
Write-Host ""
Write-Host "Extracting MSI's."
Write-Host ""


$name="Windows8.1-Server2012R2ADMX-RTM.msi"
$folder=$name.Trim(".msi")
Write-Host "Extracting $name"
Extract-MSI $name $psscriptroot\$folder

Write-Host "Moving Templates"
#Get-ChildItem $psscriptroot\$folder\PolicyDefinitions -Recurse |Move-Item -Destination c:\windows\sysvol\domain\policies\PolicyDefinitions -Force

$name="Windows10_Version_1511_ADMX.msi"
$folder=$name.Trim(".msi")
Write-Host "Extracting $name"
Extract-MSI $name $psscriptroot\$folder

Write-Host "Moving Templates"
#Get-ChildItem $psscriptroot\$folder\PolicyDefinitions -Recurse |Move-Item -Destination c:\windows\sysvol\domain\policies\PolicyDefinitions -Force





