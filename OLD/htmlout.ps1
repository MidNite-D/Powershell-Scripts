###HTML OUT
### $films | select-object name,length |convertto-html | out-file "c:\test.html"

$a = "<style>"
$a = $a + "BODY{background-color:gray;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 5px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"

get-childitem e:\films | sort Name | Select-Object Name, LastWriteTime,length | ConvertTo-HTML -head $a –body "<H2>Movies (Alpha)</H2>" | Out-File D:\Apache2\htdocs\Interface\movies.htm