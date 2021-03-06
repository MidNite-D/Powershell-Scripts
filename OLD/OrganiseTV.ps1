# Assign Paths etc.
$complete="e:\utorrent\completed"
$cleanup="e:\utorrent\clean up"
$log="e:\utorrent\Activity.log"
$shows=import-csv e:\utorrent\shows.csv
$directorylist=get-childitem $complete


# Move each flat file to TV directory
foreach ($i in $shows)
    {
    $filter=$i.filter
    $outpath=$i.path
    trap {continue}
    $command="/c move $complete\$filter"+".avi "+"""d:\tv\$outpath"""+" >>$log"
    cmd $command
    }


# Move files from directories
$target=get-childitem $complete|get-childitem -filter $filter

foreach ($d in $directorylist)
    {
    if ($d.mode -eq "d----")
        {
        
        foreach ($i in $shows)
            {
            $filter=$i.filter
            $outpath=$i.path
            $directory=$d.name
            trap {continue}
            $command="/c move ""$complete\$directory\$filter"+".avi"""+" ""d:\tv\$outpath"""+" >>$log"
            cmd $command
            }
        }
     }
     
# Look for flat file movies
foreach ($file in $directorylist)
    {
    if ($file.length -gt "650000000")
        {
        $cmd="/c move """+$complete+"\$file"""+" D:\Films"    
        cmd $cmd
        $command="/c E:\UTorrent\bmail -s smtp.blueyonder.co.uk -t andy0taylor@googlemail.com -f andy.taylor79@blueyonder.co.uk -a ""Movie Found! $file"
        cmd $command
        }
    }

# Look for movies in directories
foreach ($item in $directorylist)
    {
    if ($item.mode -eq "d----")
        {
        $directorycontents=get-childitem $complete\$item
        foreach ($file in $directorycontents)
            {
            if ($file.length -gt "650000000")
                {
                $cmd="/c move """+$complete+"\$item"+"\$file"""+" D:\Films"
                cmd $cmd
                $command="/c E:\UTorrent\bmail -s smtp.blueyonder.co.uk -t andy0taylor@googlemail.com -f andy.taylor79@blueyonder.co.uk -a ""Movie Found! $file"
                cmd $command
                }
            }
        }
    }

# Tidy Up
foreach ($d in $directorylist)
    {
    if ($d.mode -eq "d----")
        {
        $directory=$d.name
        $command="/c move ""$complete\$directory\*.*"""+" "+"""$cleanup"""+" >>$log"
        $command2="/c rd ""$complete\$directory"""
        cmd $command
        cmd $command2
        }
    }

# Email Notification

$command="/c E:\UTorrent\bmail -s smtp.blueyonder.co.uk -t andy0taylor@googlemail.com -f andy.taylor79@blueyonder.co.uk -a ""Download Complete! "" -m $log -c"
cmd $command
$command2="/c del $log"
cmd $command2

  