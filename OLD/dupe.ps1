$dir=get-childitem E:\Films
foreach ($item in $dir)

{
$fname = [System.IO.Path]::GetFileNameWithoutExtension($item)

$end=$fname.EndsWith("CD2")

if ($end="True")
    {
    
    $target = $fname.Replace("CD2", "CD1")
    move e:\films\$fname\$item e:\films\$target
    
    }
}
