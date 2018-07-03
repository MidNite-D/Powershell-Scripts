$influxserver="http://influxdb.home.404.me.uk:8086"
$influxuser="plex"
$influxpass="plex"
$db="PLEX"
$ServicePoint = [System.Net.ServicePointManager]::FindServicePoint("$influxserver/write?db=$db")
function post-influx {
    Param(
      [string]$data
      )
    $authheader = "Basic " + ([Convert]::ToBase64String([System.Text.encoding]::ASCII.GetBytes($influxuser+":"+$influxpass)))
    $uri = $influxserver+"/write?db="+$db
    Invoke-RestMethod -Headers @{Authorization=$authheader} -Uri $uri -Method POST -Body $data
    }
    
$lastpost=0

while($TRUE){
    [xml]$status = Invoke-WebRequest -UseBasicParsing -Uri http://app-01:32400/status/sessions?X-Plex-Token=pATdzyRpFfkd2eakVYWQ
    $activestreams=$status.MediaContainer.Video
    [int]$number=$status.MediaContainer.size
    Write-Host "Current Streams : $number"
    foreach($title in $status.MediaContainer.Video){
    $user=$title.user.title
    $player=$title.Player.title
    $ipaddress=$title.Player.address
    if($title.grandparenttitle){
        $name=$title.grandparenttitle + " : " + $title.title
    }
    else{
        $name=$title.title
    }
    Write-host "$user   $name"
    
    $postdata = "AndyFlix,Type=Streams CurrentSessions=" + $number
    post-influx -data $postdata
    $lastpost=$json.items.latestreading.value
    $ServicePoint.CloseConnectionGroup("")
    $postdata = "AndyFlix,Type=Sessions User=""" + $user + """,Title=""" + $name + """,Player=""" + $player + """,Address=""" + $ipaddress + """"
    post-influx -data $postdata
    $lastpost=$json.items.latestreading.value
    $ServicePoint.CloseConnectionGroup("")
}

start-sleep -Seconds (60)
    }
