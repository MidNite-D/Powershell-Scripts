##############################################################
# SCRIPT STILL REBOOTS TARGET !!!!! NEED TO LOOK AT SERVICES.#
##############################################################


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
   
   