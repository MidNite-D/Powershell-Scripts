###### Compress Arhcive Remotely
$commandline="psexec /accepteula \\ukban-pststore.iresource.local -w c:\scriptapps c:\scripitapps\7za.exe a -tzip d:\archive\leavers\$target.zip d:\archive\leavers\$target.pst"
cmd /c $commandline

