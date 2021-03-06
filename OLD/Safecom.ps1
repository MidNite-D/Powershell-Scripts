$servers=@("UKBan-Print1","UKWar-Print1","Prefile02","UKEUADS01","GlasgowFPServ","DublinDC01","IBS-BelfastDC01","IREDubDC01")
foreach ($target in $servers)
{$status=get-process -name sqlservr -computername $target
write-host $target "RAM Useage" (($status.pm/1024)/1024)}

$target=read-host "Print Server? "

$status=get-process -name sqlservr -computername $target

write-host "Current RAM Usage:-"(($status.pm/1024)/1024)"MB"

do {$restart=Read-Host "Restart Service? (y/n) "}
while ($restart -ne "y" -and $restart -ne "n")


if ($restart -eq "y")
{
get-service -name *safecommsde -computername $target
}

else
{}

