##Check OS

$OS = Get-CimInstance Win32_OperatingSystem
$OS.Caption


function CheckForPatch($KB)
{
if(Get-HotFix $KB -ErrorAction SilentlyContinue)
            {
                Write-Host "Patch Installed"
            }
        Else
            {
                Write-Host "Patch NOT Installed"
                Start-Process "https://www.catalog.update.microsoft.com/Search.aspx?q=$KB"
            }    
}
##  Check for Patch 

if($OS.Caption -eq "Microsoft Windows Server 2008 R2 Standard")
    {
        CheckForPatch("KB3212646")
    }
if($OS.Caption -eq "Microsoft Windows Server 2012 Standard")
    {
        CheckForPatch("KB3205409")
    }
if($OS.Caption -eq "Microsoft Windows Server 2012 R2 Standard")
    {
        CheckForPatch("KB3205401")
    }
if($OS.Caption -eq "Microsoft Windows Server 2016 Standard")
    {
        CheckForPatch("KB3213986")
    }
Sleep 60