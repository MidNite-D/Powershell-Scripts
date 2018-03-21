#### AUTO ELEVATE

# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator
 
# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host
   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator
   
   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess);
   
   # Exit from the current, unelevated, process
   exit
   }


$SDIPath="C:\users\andy\Desktop\SDI"
$SDIvers=Get-ChildItem -Path $SDIPath -Filter "SDI*.exe"
$latestversion=0

foreach ($SDI in $SDIvers){
    $version=$($($SDI.Name.Substring($($SDI.name.IndexOf("_R"))+2)).replace(".exe",""))/1
    if ($version -gt $latestversion){
        $latestversion=$version
    }
}

$SDIEXE=Get-ChildItem -Path $SDIPath -Filter "SDI_x64_R$latestversion.exe"

Start-Process $SDIEXE.FullName -ArgumentList "/autoupdate /autoclose"

