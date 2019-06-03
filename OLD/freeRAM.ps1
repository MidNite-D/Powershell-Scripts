function checkmem([string]$name="")
{
$mem = Get-WmiObject -Class Win32_OperatingSystem -computername $name
# Display memory
"System     : {0}" -f $mem.csname
"Free Memory: {0}" -f $mem.FreePhysicalMemory
}

checkmem .
checkmem war-appserv
checkmem ukwar-wds01
