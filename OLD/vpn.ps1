#Turns VPN services on and off.

# put status of vpn into variables
$sr=get-service sr_service
$wd=get-service sr_watchdog


# If the SR service is stopped start it... or stop it...
if ($sr.status -eq "Stopped")
{
Write-Host "Launching Checkpoint Service"
start-service sr_service
}
else
{
Write-Host "Killing Checkpoint Service"
stop-service sr_service
}

# If the Watchdog service is stopped start it... or stop it
if ($wd.status -eq "Stopped")
{
Write-Host "Launching Watchdog"
start-service sr_watchdog

# Launch GUI
Write-Host "Launching GUI"
invoke-item "C:\Program Files\CheckPoint\SecuRemote\bin\SR_GUI.exe"
}
else
{
Write-Host "Killing Watchdog"
stop-service sr_watchdog
}