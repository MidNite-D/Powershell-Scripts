
$chrome=get-process | where {$_.id -eq "0"}
$ie=get-process | where {$_.id -eq "0"}


$chrome=get-process | where {$_.processname -eq "chrome"}
$ie=get-process | where {$_.processname -eq "iexplore"}
get-process | where {$_.processname -eq "chrome"} | stop-process
get-process | where {$_.processname -eq "iexplore"} | stop-process

ICT

if ($chrome[0].processname -eq "chrome")
{
invoke-item "C:\Users\ataylor\AppData\Local\Google\Chrome\Application\chrome.exe"
}
else
{}

if ($ie[0].processname -eq "iexplore")
{
invoke-item "C:\Program Files\Internet Explorer\iexplore.exe"
}
else
{}
