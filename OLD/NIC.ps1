ge

$nic=get-wmiobject win32_networkadapter | Where {$_.deviceid -eq 7}
if ($nic.macaddress -ne "00:21:6b:44:69:06")
{
write-host "Wireless Switching On"
$nic.enable()
}
else
{
write-host "Wireless Switching Off"
$nic.disable()
}
