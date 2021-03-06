$ServerFile = "c:\users\ataylor\powershell\MyFile.txt"
$ServerList = Get-Content $ServerFile

foreach ($NextServer in $ServerList)
{
   write-host "Connecting to $NextServer..."

   $colItems=get-wmiobject win32_product -computername $NextServer

   foreach ($objItem in $colItems)
   {
       write-host "Caption: " $objItem.Caption
       write-host "Description: " $objItem.Description
       write-host "Identifying Number: " $objItem.IdentifyingNumber
       write-host "Installation Date: " $objItem.InstallDate
       write-host "Installation Date 2: " $objItem.InstallDate2
       write-host "Installation Location: " $objItem.InstallLocation
       write-host "Installation State: " $objItem.InstallState
       write-host "Name: " $objItem.Name
       write-host "Package Cache: " $objItem.PackageCache
       write-host "SKU Number: " $objItem.SKUNumber
       write-host "Vendor: " $objItem.Vendor
       write-host "Version: " $objItem.Version
       write-host
   }
}

 