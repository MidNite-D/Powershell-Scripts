##Stop/Start TED

$ted=get-service ted



if ($ted.status -eq "Running")
    {
    stop-service ted
    $process=get-process javaw
    $process.kill()
    sleep 3
    invoke-item "C:\Program Files (x86)\Torrent Episode Downloader\ted.exe"
    }
else
    {   
    get-process | where {$_.processname -eq "javaw"} | stop-process
    start-service ted
    }
   