#Turns Virtual Server services on and off.

# put status of virtual server into variables
$VS=get-service "virtual server"
$VMH=get-service vmh


# If the VS service is stopped start it... or stop it...
if ($vs.status -eq "Stopped")
{
start-service "virtual server"
}
else
{
stop-service "virtual server" -force
stop-service vmh -force
}
