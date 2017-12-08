clear
$services = @("ClickToRunSvc","AppXSvc","BFE","Bonjour Service","CertPropSvc","Browser","DiagTrack","PimIndexMaintenanceSvc_1252c55","DusmSvc","DoSvc","DPS","WdiServiceHost","WdiSystemHost","lfsvc","iphlpsvc","msoidsvc","NcbService","NVDisplay.ContainerLocalSystem","NvContainerLocalSystem","NvTelemetryContainer","PcaSvc","QWAVE","RasMan","SessionEnv","TermService","UmRdpService","SstpSvc","wscsvc","SSDPSRV","OneSyncSvc_1252c55","TapiSrv","tvnserver","TabletInputService","VeeamTransportSvc","VeeamDeploySvc","TokenBroker","WdNisSvc","stisvc","LicenseManager")
$processes= @("chrome.exe","dropbox.exe","dropboxupdate.exe","GoogleDriveFS.exe","OneDrive.exe","SkypeHost.exe","RuntimeBroker.exe","nvspcaps64.exe","nvsphelper64.exe","NVIDIA Share.exe","NVIDIA Web Helper.exe","ONENOTEM.exe","NCentralRDViewer.exe","")
foreach ($service in $services){
    Stop-Service $service -Force -NoWait
}
foreach ($process in $processes){
    taskkill.exe /f /im $process
}