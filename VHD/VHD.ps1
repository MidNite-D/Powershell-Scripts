##### VHD Toggle ####


### Check if disk is mounted ###
$check=get-childitem d:\mounted\mounted

if ($check.name -eq "mounted")
    {
    $command="diskpart /s ""D:\DropBox\My Dropbox\iSOFT\Documents\Scripting\powershell\vhd\detach.txt"""
    cmd /c $command
    }
    else
    {
    $command="diskpart /s ""D:\DropBox\My Dropbox\iSOFT\Documents\Scripting\powershell\vhd\attach.txt"""
    cmd /c $command 
    }
    