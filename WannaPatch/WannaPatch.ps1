##Check OS

$OS = Get-WMIObject Win32_OperatingSystem
$OS.Caption


function CheckForPatch($KB,$KB2)

{
$KB
$KB2
$Monthly=Get-HotFix $KB -ErrorAction SilentlyContinue
$Security=Get-HotFix $KB2 -ErrorAction SilentlyContinue

if($Monthly.hotfixid -eq $KB -or $Security.hotfixid -eq $KB2)
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

if($OS.Caption -like "*2008 Standard*")
    {
        CheckForPatch -KB "KB4012598" -KB2 "KB4012598"
    }
if($OS.Caption -like "*2008 Enterprise*")
    {
        CheckForPatch -KB "KB4012598" -KB2 "KB4012598"
    }
if($OS.Caption -like "*Server 2008 R2*")
    {
        CheckForPatch -KB "KB4012212" -KB2 "KB4012215"
    }
if($OS.Caption -eq "Microsoft Windows Server 2012 Standard")
    {
        CheckForPatch -KB "KB4012214" -KB2 "KB4012217"
    }
if($OS.Caption -like "*Windows Server 2012 R2*")
    {
        CheckForPatch -KB "KB4012213" -KB2 "KB4012216"
    }
if($OS.Caption -like "*Windows Server 2016*")
    {
        CheckForPatch -KB "KB4013429" -KB2 "KB4013429"
    }
Sleep 60