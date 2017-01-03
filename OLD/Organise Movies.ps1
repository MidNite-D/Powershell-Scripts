$newfiles=import-csv "D:\uTorrent\Organise Movie\newfiles.csv"
$filters=import-csv "D:\uTorrent\Organise Movie\filters.csv"

foreach ($file in $newfiles)
    {
    if ($file.filename -match ".avi")
        {
        $fname=$file.filename
        $fname = (Split-Path $fname -leaf).ToString().Replace(".avi", "")
        $fname = (Split-Path $fname -leaf).ToString().Replace(".", " ")


        foreach ($filter in $filters)
            {
            $fname = (Split-Path $fname -leaf).ToString().Replace($filter.filter, "")
            }
            
        $fname=$fname+".avi"
        & cmd.exe /c rename $file.filename $fname  
            }
    }
