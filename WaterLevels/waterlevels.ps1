$influxserver="http://influxdb.home.404.me.uk:8086"
$influxuser="pshell"
$influxpass="pshell"
$db="PowershellStats"
$ServicePoint = [System.Net.ServicePointManager]::FindServicePoint("http://influxdb.home.404.me.uk:8086/write?db=$db")
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
  $json = Invoke-WebRequest -Uri https://environment.data.gov.uk/flood-monitoring/id/stations/L1203/measures| ConvertFrom-Json
  $waterlevel=$json.items.latestreading.value.ToString()
  write-host "Water Level : $waterlevel m"
  if ($json.items.latestreading.value -ne $lastpost){
    $postdata = "WaterLevel,Location=CopleyBridge value=" + $waterlevel
    post-influx -data $postdata
    $lastpost=$json.items.latestreading.value
    $ServicePoint.CloseConnectionGroup("")
  }
start-sleep -Seconds (60*15)
}

