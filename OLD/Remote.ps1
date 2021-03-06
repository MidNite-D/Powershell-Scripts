###################################
#Script to control remote funtions#
###################################


###########
#Functions#
###########


#Enable RDP#
############
    function RDPON
        {
        $machinename=$args[0]
        $regKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $MachineName)
 
        # $True makes regKey writable  
        $regKey= $regKey.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\Terminal Server" ,$True)
 
        # the Setting is Deny so I reverse it first with ! to set $RDPenabled  
        $RDPEnabled = !([system.boolean]$regkey.getvalue('fDenyTSConnections'))
 
        write-host "$MachineName RDP = $RDPEnabled"
        If (!$RDPEnabled) {
            $regkey.SetValue('fDenyTSConnections',0)
            #write changes without closing key
            $regKey.flush()
            write-Host "enabled RDP on $MachineName"
            sleep 1
        }

  
        #If changed set the Key back to original value :
        #if (!$RDPEnabled) {
        #  $regkey.SetValue('fDenyTSConnections',[int]!$RDPEnabled);
        #  write-Host "Disabled RDP again on $MachineName"
        #}

        #Close the Reg Key
        $regKey.Close()
        cls
    }


#Reboot#
########
    function reboot
        {
        param ($machinename=".", $delay="001")
        #$machinename=$args[0]
  
        # Reboot target machine 
        "Rebooting $MachineName"
  
         #Method one (looks cleaner)
         cmd /c shutdown /r /m \\$machinename /t $delay
  
         #Method two
         #(GWMI win32_operatingsystem -ComputerName $machinename).Win32Shutdown(6)
         sleep 3
         }  


#RDP Connection#
################
    function connect
        {
        $machinename=$args[0]
        cmd /c mstsc /v:$machinename /f
    }
   
   
##################
#End of functions#
##################




#Clear any old variables.

    $target=""
    $response=""
    $credcheck=""


    cls

#Aquire Valid Machine Name
    do
    {
        $Target=Read-Host "Target Machine :"
        cls
        Write-Host "Target Machine : $target"
        $response=cmd /c ping $target -n 1
        $responsecheck="Ping request could not find host $target. Please check the name and try again."

        if ($response -eq $responsecheck)
            {
                Write-Host "Unable to find $target, please ensure that $target responds to ping."
            }
    }
    while ($response -eq $responsecheck)

#Test Credentials
    Write-Host "Checking Credentials."
    sleep 1
    trap {continue}
    
    $credcheck=gwmi win32_computersystem -computer $target
    cls
    if ($credcheck)
        {
        Write-Host "Target Machine : $target"
        Write-Host "Checking Credentials"
        Write-Host "Credentials Accepted."
        }
    else
        {
        Write-Host "Target Machine : $target"
        Write-Host "Checking Credentials"
        Write-Host "Access Denied.  Unless you have specific administration permissions on $target these scripts will fail."
        }
   
   
   
#Menu
 $funclist=@("1   Reboot","2   Enable RDP","3   RDP Session","X   Exit")
 $funclist

 do
    {
    $selection=read-host
#Reboot    
    if ($selection -eq "1")
        {
        cls
        Write-Host "Target Machine : $target"
        reboot ($target)
        sleep 2
        Write-Host "Target Machine : $target"
        $funclist
        }
#Enable RDP  
    if ($selection -eq "2")
        {
        cls
        Write-Host "Target Machine : $target"
        rdpon ($target)
        sleep 2
        Write-Host "Target Machine : $target"
        $funclist
        }
#RDP Connection        
    if ($selection -eq "3")
        {
        cls
        Write-Host "Target Machine : $target"
        connect ($target)
        sleep 2
        Write-Host "Target Machine : $target"
        $funclist
        }  
    }
#Repeat until exit. 
 until ($selection -eq "X")
 
 