#Get-WmiObject Win32_OperatingSystem | Get-Member -MemberType Property
get-wmiobject win32_operatingsystem | export-csv "c:\users\ataylor\powershell\system.csv"
$details=get-wmiobject win32_operatingsystem
write-host "OS - "$details.name
write-host "Boot Device - "$details.bootdevice
Write-host "Boot Time - "$details.lastbootuptime
write-host "Total RAM - "($details.totalvisiblememorysize/1024)"MB"

