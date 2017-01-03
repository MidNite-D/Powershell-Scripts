$server="."
$wmi=Get-WmiObject -class Win32_OperatingSystem -computer $server
$LBTime=$wmi.ConvertToDateTime($wmi.Lastbootuptime)
[TimeSpan]$uptime=New-TimeSpan $LBTime $(get-date)
Write-host "Server Uptime: ” $uptime.days “Days” $uptime.hours “Hours” $uptime.minutes “Minutes” $uptime.seconds “Seconds”