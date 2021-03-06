$newKey=read-host "Generate new AES key? (y/n)"

if($newKey -eq "y"){
    $AESKey = New-Object Byte[] 32
    [Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($AESKey)
    # Store the AESKey into a file. This file should be protected!  (e.g. ACL on the file to allow only select people to read)
    Set-Content .\AESKey.txt $AESKey   # Any existing AES Key file will be overwritten		
    }
$password = read-host "String to encrypt" -AsSecureString | ConvertFrom-SecureString -Key $AESKey
Add-Content .\CredFile $password
