$comments = @'
Script name: CreateSave-Word.ps1
Created on: Wednesday, March 21, 2007
Author: Kent Finkle
Purpose: How can I use Windows Powershell to
Create and Save a Word Document?
'@

$objWord = New-Object -comobject Word.Application
$objWord.Caption = "Test Caption"
$objWord.Visible = $True

$objDoc = $objWord.Documents.Add()
$objSelection = $objWord.Selection

$objSelection.Font.Name = "Arial"
$objSelection.Font.Size = "18"
$objSelection.TypeText("Network Adapter Report")
$objSelection.TypeParagraph()

$objSelection.Font.Size = "14"
$a = get-date –format d
$objSelection.TypeText("" + $a)
$objSelection.TypeParagraph()
$objSelection.TypeParagraph()

$objSelection.Font.Size = "10"

$sql = "Select * from Win32_NetworkAdapterConfiguration"
$colItems = gwmi -query $sql

foreach ($objItem in $colItems) {

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("ARP Always Source Route: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.ArpAlwaysSourceRoute)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("ARP Use EtherSNAP: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.ArpUseEtherSNAP)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Caption: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.Caption)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Database Path: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.DatabasePath)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Dead GW Detection Enabled: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.DeadGWDetectEnabled)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Default IP Gateway: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.DefaultIPGateway)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Default TOS: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.DefaultTOS)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Default TTL: ")
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.DefaultTTL)
    $objSelection.TypeParagraph()

    $objSelection.Font.Bold = $True
    $objSelection.TypeText("Description: ")
    $objSelection.Font.Bold = $True
    $objSelection.Font.Bold = $False
    $objSelection.TypeText("" + $objItem.Description)
    $objSelection.TypeParagraph()

    $objSelection.TypeParagraph()

}

$objDoc.SaveAs([ref] "C:\testdoc.doc")
$a = $objWord.Quit()