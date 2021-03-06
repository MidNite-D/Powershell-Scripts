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
$NonTV = get-childitem "d:\utorrent\non tv"

### Functions ###

function op($text)
{
$text|out-file -append $RepFile
}



################  FILMS  ###################

## Films
## Filmcount
## FilmSize
## FilmGB
## SRTFilmsMod
## LatestFilms


### Film Count + Sizes ###

$films=get-childitem $FilmStoreA |where {$_.name -match ".avi" -or $_.name -match ".mpg" -or $_.name -match ".mp4"}

foreach ($item in $films)
    {
    $filmcount=$filmcount+1
    $x=$item.length
    $filmsize=$filmsize+$x
    }

$FILMGB=$filmsize/$GB

### Films Access Stats ###

$SRTFilmsMod=$films | sort LastWriteTime 
$LatestFilms=@($SRTFilmsMod[$filmcount-1],$SRTFilmsMod[$filmcount-2],$SRTFilmsMod[$filmcount-3],$SRTFilmsMod[$filmcount-4],$SRTFilmsMod[$filmcount-5])













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

### Files to Organise ###
$nontv=$nontv|select name|sort name




######### WRITE A REPORT ###########


$RepFile="c:\ServerReport.txt"
remove-item $RepFile
$str="Server Report for : "+$VolumeInfo[0].systemname+" On "+$date
op $str
op $btime
op $suptime
op "------------------------------------------------------------------------------------------------------------------"
op "CURRENT STORAGE"
op "------------------------------------------------------------------------------------------------------------------"
$str=$volumeinfo|select Name,DriveLetter,Capacity,Freespace|sort DriveLetter|ft
op $str
$inuse=($volumeinfo[1].capacity - $volumeinfo[1].freespace) / $GB
op "------------------------------------------------------------------------------------------------------------------"
$str= "STORE A (Drive E:)    ["+$inuse+" GB IN USE]"
op $str
op "------------------------------------------------------------------------------------------------------------------"
op "Movies : $FilmCount Files Using $FilmGB GB"
$str = "              "+$FilmNotRead.name+" has not been accessed since "+$FilmNotRead.lastaccesstime
op $str
op "Latest Movies:"
foreach ($item in $latestfilms)
    {
    op $item.name
    }
op "TV       : $TVCount Files Using $TVGB GB"
$str = "              "+$TVNotRead.name+" has not been accessed since "+$TVNotRead.lastaccesstime
op $str
op "Music  : $MusicCount Files Using $MusicGB GB"
$str = "              "+$MusicNotRead.name+" has not been accessed since "+$MusicNotRead.lastaccesstime
op $str
op "------------------------------------------------------------------------------------------------------------------"
op "UNSORTED FILES"
op "------------------------------------------------------------------------------------------------------------------"
foreach ($item in $nontv)
    {
    $str=$item.name
    op $str
    }



#######  mail it ###

$command = "/c ""d:\utorrent\notify\bmail.exe -s relay.plus.net -t andy0taylor@googlemail.com -f Home.Server@Home.Net -a ""Server Report "+$date+""" -c -m "+$repfile+""""
cmd $command
remove-item $RepFile
