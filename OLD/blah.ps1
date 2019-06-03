$dir=get-childitem e:\films\*CD1
foreach ($item in $dir)
{
write-host $item
$source=$item.name
$target = $source.replace(".cd1", "")

    write-host $target
    rename-item e:\films\$source e:\films\$target
}