
$objWord = New-Object -comobject Word.Application
$objWord.Caption = "You Are A Fish"
$objWord.Visible = $True

$objDoc = $objWord.Documents.Add()
$objSelection = $objWord.Selection

$objSelection.Font.Name = "Arial"
$objSelection.Font.Size = "22"
$objSelection.TypeText("YOU ARE A FISH")
$objSelection.TypeParagraph()


$objselection.style = "No Spacing"
$objSelection.Font.Size = "14"
$a = get-date
$objSelection.TypeText("" + $a)
$objSelection.TypeParagraph()
$objSelection.TypeParagraph()
$objselection.TypeText("monkey tree")

$objselection.TypeText("monkey tree")
$files=get-childitem c:\windows
$objselection.font.size = "9"
$objselection.font.color = "wdcolorgreen"
foreach ($item in $files)
{
$objselection.typetext(""+$item)
$objselection.typeparagraph()
}
