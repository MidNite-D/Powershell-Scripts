Function ICT
{

cd HKCU:\"Software\Microsoft\Windows\CurrentVersion\Internet Settings"
set-itemproperty . ProxyEnable 1
set-itemproperty . ProxyServer 159.170.25.16:808
set-itemproperty . ProxyOverride "159.170.*.*"

#new-itemproperty . AutoConfigURL
set-itemproperty . AutoConfigURL ""
}

Function NONE
{

cd HKCU:\"Software\Microsoft\Windows\CurrentVersion\Internet Settings"
set-itemproperty . ProxyEnable 0
set-itemproperty . ProxyServer ""
set-itemproperty . ProxyOveride ""
set-itemproperty . AutoConfigURL ""
}

Function ISOFT
{

cd HKCU:\"Software\Microsoft\Windows\CurrentVersion\Internet Settings"
set-itemproperty . AutoConfigURL "159.170.168.65\wpad.dat"
set-itemproperty . ProxyEnable 0
set-itemproperty . ProxyServer ""
set-itemproperty . ProxyOveride ""
}


CLS
Write-Host "1...   Corporate Proxy"
Write-Host "2...   ICT Proxy"
Write-Host "3...   No Proxy"
$selection=read-host

if ($selection -eq "1")
{
ISOFT
}

if ($selection -eq "2")
{
ICT
}

if ($selection -eq "3")
{
NONE
}

