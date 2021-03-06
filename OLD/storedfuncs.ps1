#---------------------
#-  Stored Functions -
#---------------------


#-----------------------
#- Switches LAN on/off -
#-----------------------
# Parameters = adaptorid, mac

function lanswitch
{
param ($id="16",$mac="00:22:64:76:F4:3B") 
$nic=get-wmiobject win32_networkadapter | Where {$_.deviceid -eq $id}
if ($nic.macaddress -ne $mac)
{
write-host "LAN Switching On"
$nic.enable()
}
else
{
write-host "LAN Switching Off"
$nic.disable()
}
}

#------------------------
#- Switches WIFI on/off -
#------------------------
# Parameters = adaptorid, mac

function wifiswitch
{
param ($id="14",$mac="00:21:6b:44:69:06")
$nic=get-wmiobject win32_networkadapter | Where {$_.deviceid -eq 14}
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
}

