

$date = Get-Date
## --------- Fill this bit in
$description = "Disabled by AT on $date."
$ou = "OU=Blackgates Users,DC=Blackgatescurr,DC=local"
$disabledOU = "OU=disabled,OU=Blackgates Users,DC=Blackgatescurr,DC=local"
$logfile = "C:\disbaled.csv"
$days="-30"
$move="no"
##=====================================================================

$date = Get-Date
write-host -foregroundcolor yellow "Disabling old user accounts."

$finduser = Get-aduser –filter * -SearchBase $ou -properties cn,lastlogondate | 
Where {$_.LastLogonDate –le [DateTime]::Today.AddDays($days) -and ($_.lastlogondate -ne $null) }

$finduser | export-csv $logfile
$finduser | set-aduser -Description $description –passthru | Disable-ADAccount


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
