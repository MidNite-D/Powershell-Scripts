##Stop/Start µTorrent

$utorrent=get-service utorrent



if ($utorrent.status -eq "Running")
    {
    stop-service utorrent
    sleep 3
    invoke-item "D:\uTorrent\uTorrent.exe"
    }
else
    {   
    get-process | where {$_.processname -eq "utorrent"} | stop-process
    sleep 2
    start-service utorrent
    }
   