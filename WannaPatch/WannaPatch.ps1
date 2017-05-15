##Check OS

$OS = Get-CimInstance Win32_OperatingSystem
$OS.Caption


function CheckForPatch($KB,$KB2)
{
if(Get-HotFix $KB -ErrorAction SilentlyContinue -or Get-HotFix $KB2 -ErrorAction SilentlyContinue)
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
        CheckForPatch("KB4012212","KB4012215")
    }
if($OS.Caption -eq "Microsoft Windows Server 2012 Standard")
    {
        CheckForPatch("KB4012214","KB4012217")
    }
if($OS.Caption -eq "Microsoft Windows Server 2012 R2 Standard")
    {
        CheckForPatch("KB4012213","KB4012216")
    }
if($OS.Caption -eq "Microsoft Windows Server 2016 Standard")
    {
        CheckForPatch("KB4013429,KB4013429")
    }
Sleep 60