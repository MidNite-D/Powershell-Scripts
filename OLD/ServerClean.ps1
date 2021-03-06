### $films | select-object name,length |convertto-html | out-file "c:\test.html"

### Variables ###

$InstallDir="D:\DropBox\My Dropbox\iSOFT\Documents\Scripting\Powershell"
$FilmStoreA="e:\films"
$TVStoreA="e:\tv"
$MusicStoreA="e:\music"
$Date=get-date
$GB=1073741824
$FilmCount=0
$FilmSize=0
$TVCount=0
$TVSize=0
$MusicCount=0
$MusicSize=0
$RepFile="c:\Report1.txt"
$Volumeinfo = Get-WmiObject Win32_Volume -ComputerName . | Select-Object SystemName,Label,Name,DriveLetter,DriveType,Capacity,Freespace

### Functions ###

function op($text)
{
$text|out-file -append $RepFile
}



### Film Count ###

$films=get-childitem $FilmStoreA |where {$_.name -match ".avi" -or $_.name -match ".mpg" -or $_.name -match ".mp4"}
$FilmNotRead=$films[1]
foreach ($item in $films)
    {
    $filmcount=$filmcount+1
    $x=$item.length
    $filmsize=$filmsize+$x
    if ($item.lastaccesstime -lt $FilmNotRead.lastaccesstime)
        {
        $FilmNotRead=$item
        }
    }
$FILMGB=$filmsize/$GB


### TV Count ####

$tv=get-childitem -recurse $TVStoreA |where {$_.name -match ".avi"}
$TVNotRead=$tv[1]

foreach ($item in $tv)
    {
    $TVcount=$TVcount+1
    $y=$item.length
    $TVSize=$TVSize+$y
    if ($item.lastaccesstime -lt $TVNotRead.lastaccesstime)
        {
        $TVNotRead=$item
        }
    }
$TVGB=$TVSize/$GB

### Music Count ###

$music=get-childitem -recurse $MusicStoreA |where {$_.name -match ".mp3"}
$MusicNotRead=$music[1]

foreach ($item in $music)
    {
    $MusicCount=$MusicCount+1
    $z=$item.length
    $MusicSize=$Musicsize+$z
    if ($item.lastaccesstime -lt $MusicNotRead.lastaccesstime)
        {
        $MusicNotRead=$item
        }
    }
$MusicGB=$MusicSize/$GB


### Uptime ###
$wmi=Get-WmiObject -class Win32_OperatingSystem -computer .
$LBTime=$wmi.ConvertToDateTime($wmi.Lastbootuptime)
[TimeSpan]$uptime=New-TimeSpan $LBTime $(get-date)
$SUptime="Server Uptime   : ”+$uptime.days+“ Days  ”+$uptime.hours+“ Hours  ”+$uptime.minutes+“ Minutes  ”+$uptime.seconds+“ Seconds”
$Btime="Server Power On : "+$LBTime
### Drive Info ###





######### WRITE A REPORT ###########


$RepFile="c:\ServerReport.txt"
remove-item $RepFile
$str="Server Report for : "+$VolumeInfo[0].systemname+" On "+$date
op $str
op " "
op " "
op "Current Storage"
op "------------------------------"
op " "
$str=$volumeinfo|select Name,DriveLetter,Capacity,Freespace|sort DriveLetter|ft
op $str
op " "
op "STORE A (Drive E:)"
op "------------------------------------"
op " "
op "Movies : $FilmCount Files Using $FilmGB GB"
$str = "         "+$FilmNotRead.name+" has not been accessed since "+$FilmNotRead.lastaccesstime
op $str
op " "
op "TV     : $TVCount Files Using $TVGB GB"
$str = "         "+$TVNotRead.name+" has not been accessed since "+$TVNotRead.lastaccesstime
op $str
op " "
op "Music  : $MusicCount Files Using $MusicGB GB"
$str = "         "+$MusicNotRead.name+" has not been accessed since "+$MusicNotRead.lastaccesstime
op $str
op " "
op " "
op " "
op $btime
op $suptime


#######  mail it ###

$command = "/c ""d:\utorrent\notify\bmail.exe -s relay.plus.net -t andy0taylor@googlemail.com -f Home.Server@Home.Net -a ""Server Report "+$date+""" -c -m "+$repfile+""""
cmd $command
