$NewFile=$Args[0]
#$NewFile="c:\users\admin\desktop\new folder\test.avi"

$ie = new-object -comobject "InternetExplorer.Application"
$ie.visible = $false

$NewFile = (Split-Path $NewFile -leaf).ToString().Replace("d:\films\", "")
$NewFile = (Split-Path $NewFile -leaf).ToString().Replace(".avi", "")

function xbmcout ($text)
{
$str="http://xbmc:xbmc@192.168.0.3/xbmcCmds/xbmcHttp?command=ExecBuiltin(Notification($text))"
$ie.navigate($str)
}

xbmcout "New Film Available,,6000"
sleep 1
xbmcout "New Film Available,$Newfile,6000"

sleep 1
get-process | where {$_.processname -eq "iexplore"} | stop-process
