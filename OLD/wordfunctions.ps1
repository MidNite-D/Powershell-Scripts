### Create Word Doc

$objWord = New-Object -comobject Word.Application
$objWord.Caption = "You Are A Fish"
$objWord.Visible = $True
$objDoc = $objWord.Documents.Add()
$objin = $objWord.Selection



function wri($text)
{
$objin.TypeText($text)
}

function setit($setting,$entry)
{
if ($setting="col")
    {
    $objin.font.color=$entry
    }
if ($setting="font")
    {
    $objin.font.name=$entry
    }
if ($setting="size")
    {
    $objin.font.size=$entry
    }
if ($setting="style")
    {
k    }
}

function line($numberof)
{
    $counter=0
    while ($counter -lt $numberof)
        {
        $objin.typeParagraph()
        $counter=$counter+1
        }
}
   
   
setit "font" "Times New Roman"
setit "size" "24"
wri $a
line 1
wri $a


