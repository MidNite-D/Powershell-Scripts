$dir=get-childitem f:\Films
foreach ($item in $dir)

{

$fname = [System.IO.Path]::GetFileNameWithoutExtension($item)

new-item f:\films\$fname -type directory
move f:\films\$item f:\films\$fname
}
