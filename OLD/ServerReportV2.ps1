### $films | select-object name,length |convertto-html | out-file "c:\test.html"

### Variables ###

$InstallDir="D:\DropBox\My Dropbox\iSOFT\Documents\Scripting\Powershell"
$FilmStoreA="e:\films"
$TVStoreA="e:\tv"
$MusicStoreA="f:\music"
$Date=get-date
$GB=1073741824
$FilmCount=0
$FilmSize=0
$TVCount=0
$TVSize=0
$MusicCount=0
$MusicSize=0
$RepFile="c:\Report1.txt"
$Volumeinfo = Get-WmiObject Win32_Volume -ComputerName . | Select-Object SystemName,Label,Name,DriveLetter,DriveType,Capacity,Freespace | sort driveletter
$NonTV = get-childitem "d:\utorrent\non tv"

### Functions ###

function op($text)
{
$text|out-file -append $RepFile
}

function wri($text)
{
$objin.TypeText($text)
}

function line($numberof)
{
    $counter=0
    while ($counter -lt $numberof)
        {
        $objin.typeParagraph()
        $counter=$counter+1
        }
}


################  FILMS  ###################


### Film Count + Sizes ###

$films=get-childitem $FilmStoreA |where {$_.name -match ".avi" -or $_.name -match ".mpg" -or $_.name -match ".mp4" -or ".img"}

foreach ($item in $films)
    {
    $filmcount=$filmcount+1
    $x=$item.length
    $filmsize=$filmsize+$x
    }

$FILMGB=$filmsize/$GB

### Films Access Stats ###

$SRTFilmsMod=$films | sort LastWriteTime 
$LatestFilms=@($SRTFilmsMod[$filmcount-1],$SRTFilmsMod[$filmcount-2],$SRTFilmsMod[$filmcount-3],$SRTFilmsMod[$filmcount-4],$SRTFilmsMod[$filmcount-5],$SRTFilmsMod[$filmcount-6],$SRTFilmsMod[$filmcount-7],$SRTFilmsMod[$filmcount-8],$SRTFilmsMod[$filmcount-9],$SRTFilmsMod[$filmcount-10])




############### TV ###################


### TV Count + Size ####

$tv=get-childitem -recurse $TVStoreA |where {$_.name -match ".avi"}

foreach ($item in $tv)
    {
    $TVcount=$TVcount+1
    $y=$item.length
    $TVSize=$TVSize+$y
    }
    
### TV Access Stats ###
$SRTTV=$tv |sort LastWriteTime
$LatestTV=@($SRTTV[$TVcount-1],$SRTTV[$TVcount-2],$SRTTV[$TVcount-3],$SRTTV[$TVcount-4],$SRTTV[$TVcount-5],$SRTTV[$TVcount-6],$SRTTV[$TVcount-7],$SRTTV[$TVcount-8],$SRTTV[$TVcount-9],$SRTTV[$TVcount-10])


######################### MUSIC ########################

### Music Count + Size ###

$music=get-childitem -recurse $MusicStoreA |where {$_.name -match ".mp3"}

foreach ($item in $music)
    {
    $MusicCount=$MusicCount+1
    $z=$item.length
    $MusicSize=$Musicsize+$z
    }
### Music Access Stats ###
$SRTMusic=$music |sort LastWriteTime
$Latestmusic=@($SRTmusic[$musiccount-1],$SRTmusic[$musiccount-2],$SRTmusic[$musiccount-3],$SRTmusic[$musiccount-4],$SRTmusic[$musiccount-5],$SRTmusic[$musiccount-6],$SRTmusic[$musiccount-7],$SRTmusic[$musiccount-8],$SRTmusic[$musiccount-9],$SRTmusic[$musiccount-10])


### Uptime ###
$wmi=Get-WmiObject -class Win32_OperatingSystem -computer .
$LBTime=$wmi.ConvertToDateTime($wmi.Lastbootuptime)
[TimeSpan]$uptime=New-TimeSpan $LBTime $(get-date)
$SUptime="Server uptime       :  ”+$uptime.days+“ Days  ”+$uptime.hours+“ Hours  ”+$uptime.minutes+“ Minutes  ”+$uptime.seconds+“ Seconds”
$Btime="Server power on  :  "+$LBTime

### Files to Organise ###
$nontv=$nontv|select name|sort name




######### WRITE A REPORT ###########

### Create Word Doc

$objWord = New-Object -comobject Word.Application
$objWord.Caption = "Server Report"
$objWord.Visible = $False
$objDoc = $objWord.Documents.Add()
$objin = $objWord.Selection

$objin.style = "Title"
$objin.font.size = "18"
$objin.font.bold = $True
wri "Report Updated : "
$a=get-date
wri $a
line 1
$objin.style ="No Spacing"
wri $btime
line 1
wri $SUptime
line 2


$objin.style ="Title"
$objin.font.size = "14"
$objin.font.bold = $True
wri "Storage"
line 1
$objin.style = "No Spacing"
foreach ($drive in $volumeinfo)
{
$txt= "Drive   " + $drive.driveletter
$objin.font.bold=$true
wri $txt
line 1
$cap = "{0:N2}" -f ($drive.capacity / $gb)
$txt= "Capacity       :   " + $cap +"GB"
$objin.font.bold=$false
wri $txt
line 1
$cap = "{0:N2}" -f ($drive.freespace / $gb)
$txt= "Free Space  :   " + $cap +"GB"
wri $txt
line 2
}
line 1


$objin.style ="Title"
$objin.font.size = "14"
$objin.font.bold = $True
wri "Movies"
line 1
$objin.style = "No Spacing"
$txt = "Total Files        :  "+$filmcount
wri $txt
line 1
$cap = "{0:N2}" -f ($filmsize / $gb)
$txt = "Space Used      :  "+$cap+"GB"
wri $txt
line 2
$objin.font.bold=$true
wri "Latest Files"
line 1
$objin.font.bold=$false
foreach ($film in $latestfilms)
    {
    $filmdate=$film.LastWriteTime
    $strdate=$filmdate.tostring()
    $txt=$strdate+"        "+$film.name
    wri $txt
    line 1
    }
line 2


$objin.style ="Title"
$objin.font.size = "14"
$objin.font.bold = $True
wri "TV"
line 1
$objin.style = "No Spacing"
$txt = "Total Files        :  "+$tvcount
wri $txt
line 1
$cap = "{0:N2}" -f ($tvsize / $gb)
$txt = "Space Used      :  "+$cap+"GB"
wri $txt
line 2
$objin.font.bold=$true
wri "Latest Files"
line 1
$objin.font.bold=$false
foreach ($show in $latesttv)
    {
    $showdate=$show.LastWriteTime
    $strdate=$showdate.tostring()
    $txt=$strdate+"        "+$show.name
    wri $txt
    line 1
    }
line 2


$objin.style ="Title"
$objin.font.size = "14"
$objin.font.bold = $True
wri "Music"
line 1
$objin.style = "No Spacing"
$txt = "Total Files        :  "+$musiccount
wri $txt
line 1
$cap = "{0:N2}" -f ($musicsize / $gb)
$txt = "Space Used      :  "+$cap+"GB"
wri $txt
line 2
$objin.font.bold=$true
wri "Latest Files"
line 1
$objin.font.bold=$false
foreach ($song in $latestmusic)
    {
    $songdate=$song.LastWriteTime
    $strdate=$songdate.tostring()
    $txt=$strdate+"        "+$song.name
    wri $txt
    line 1
    }
line 2


### Save it

$wdformathtml = 8
$spath = "D:\Apache2\htdocs\Interface\Report1.html"
$objdoc.saveas([ref] $spath, [ref]$wdFormathtml)
### Close Word
get-process | where {$_.processname -eq "winword"} | stop-process


### File Details ###

### Movies Alpha

$a = "<style>"
$a = $a + "BODY{background-color:white;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"

$films | sort Name | Select-Object Name, LastWriteTime,length | ConvertTo-HTML -head $a | Out-File D:\Apache2\htdocs\Interface\moviesalpha.htm

### Movies Date

$a = "<style>"
$a = $a + "BODY{background-color:white;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"

$films | sort LastWriteTime -descending | Select-Object Name, LastWriteTime,length | ConvertTo-HTML -head $a | Out-File D:\Apache2\htdocs\Interface\moviesdate.htm


#######  mail it ###

#$command = "/c ""d:\utorrent\notify\bmail.exe -s relay.plus.net -t andy0taylor@googlemail.com -f Home.Server@Home.Net -a ""Server Report "+$date+""" -c -m "+$repfile+""""
#cmd $command


### Restart Apache
#stop-service apache2.2
#start-service apache2.2

#invoke-item "D:\Apache2\htdocs\Interface\Report1.html"
