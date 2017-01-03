

$date = Get-Date
## --------- Fill this bit in
$ou = "OU=2011,OU=Pupils,OU=Curriculum,OU=Users,OU=Ninelands Primary,DC=nps,DC=lan"  # OU to search for accounts
$disabledOU = "OU=Staff,OU=Users,OU=ARCHIVE,OU=Ninelands,DC=nps,DC=lan" # OU to move disbaled accounts to
$logfile = "C:\disabled.csv" # make sure script has write permission
$days="-90" # must be nagative number
$disable="no"  # test for old accounts without disabling - logged to console and file
$description = "Disabled by AT on $date."
$move="no"  # move accounts do the disabled OU?
$UserDataPath="D:\Users\Staff"
$ArchiveDataPath="D:\Users\ARCHIVE\Staff"
##=====================================================================

write-host -foregroundcolor yellow "Searching for old user accounts."

$finduser = Get-aduser –filter * -SearchBase $ou -properties cn,lastlogondate | 
Where {$_.LastLogonDate –le [DateTime]::Today.AddDays($days) -and ($_.lastlogondate -ne $null) }

$finduser | export-csv $logfile

foreach($user in $finduser){
write-host -foregroundcolor red $user.CN
}

if($disable -eq "yes")
{
write-host -foregroundcolor yellow "Disabling old user accounts."
$finduser | set-aduser -Description $description –passthru | Disable-ADAccount
}

if($move -eq "yes")
{
write-host -foregroundcolor yellow "Searching OU for disabled Accounts"
[System.Threading.Thread]::Sleep(500)
$disabledAccounts = Search-ADAccount -AccountDisabled -UsersOnly -SearchBase $ou

write-host -foregroundcolor yellow "Moving disabled Accounts to the disabled OU"
[System.Threading.Thread]::Sleep(500)
$disabledAccounts | Move-ADObject -TargetPath $disabledOU
}
if($move -eq "yes")
{
write-host -ForegroundColor yellow "Moving User Data"
[System.Threading.Thread]::Sleep(500)

foreach($user in $finduser){
write-host -foregroundcolor red $user.CN
$username=$user.SamAccountName
Move-Item $UserDataPath\$username $ArchiveDataPath\$username
}
}
write-host -foregroundcolor yellow "Script Complete."