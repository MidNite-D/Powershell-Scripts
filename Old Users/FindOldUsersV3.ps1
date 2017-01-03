

$date = Get-Date
## --------- Fill this bit in
$ou = "OU=Users,OU=Staff,OU=Hilltop,DC=Hilltop-Curr,DC=local"  # OU to search for accounts
$disabledOU = "OU=ARCHIVE,OU=Hilltop,DC=Hilltop-Curr,DC=local" # OU to move disbaled accounts to
$logfile = "C:\disabled.csv" # make sure script has write permission
$days="-60" # must be nagative number
$disable="no"  # test for old accounts without disabling - logged to console and file
$description = "Disabled by AT on $date."
$move="no"  # move accounts do the disabled OU?
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

write-host -foregroundcolor yellow "Script Complete"