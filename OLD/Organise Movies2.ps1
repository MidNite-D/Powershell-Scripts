### Set paths and import filters.
sleep 45
$srcpath="d:\utorrent\non tv\"
$flmpath="e:\films\"
$filters=import-csv "D:\uTorrent\Organise Movie\filters.csv"

### Check for Avi's files then remove filtered strings.

$list=get-childitem -recurse $srcpath

foreach ($item in $list)
    {
    if ($item.name -match ".avi")
        {
        $fname=$item.name
        $fname = (Split-Path $fname -leaf).ToString().Replace(".avi", "")
        $fname = (Split-Path $fname -leaf).ToString().Replace(".", " ")
        
        foreach ($filter in $filters)
            {
            $fname = (Split-Path $fname -leaf).ToString().Replace($filter.filter, "")
            }


############THIS BIT DOESNT WORK NEED TO GET CORRECT PATH use method psparentpath####



        
###  Rename and move the finished file to Films directory.        
        
        $fname=$fname+".avi"
        $buildcommand="/c move """+$srcpath+$item.name+""" "+""""+$flmpath+$fname+""""   
        $command=$buildcommand
        cmd $command
        
###  Send email notification.
        
        $buildncommand="/c d:\utorrent\notify\bmail.exe -s relay.plus.net -t andy0taylor@googlemail.com -f New-Download@Home.Server -a """+$fname+" added to Movies directory :)"+""""
        $ncommand=$buildncommand
        cmd $ncommand      
        }
    }