Function add
{
    param ([int]$x=0,[int]$y=0)
    
    $result=$x+$y
    Write-Host "$x + $y = $result"
}
add 1,2

Function finhosts
{
    $input|where-object{$_.Name -eq "hosts"}
}



get-childitem -path c:\ -recurse |finhosts

