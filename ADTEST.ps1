$ADDomain=Get-ADDomain
New-ADOrganizationalUnit -Name "Connect" -path $ADDomain.DistinguishedName
New-ADGroup -Name "Connect Up" -GroupCategory Security -GroupScope DomainLocal -Path "OU=Connect,$($ADDomain.DistinguishedName)"
New-ADGroup -Name "Connect Up Administrators" -GroupCategory Security -GroupScope Global -Path "OU=Connect,$($ADDomain.DistinguishedName)"
Add-ADGroupMember -Identity "Connect UP" -Members "Connect Up Administrators"
Add-ADGroupMember -Identity "Domain Admins" -Members "Connect Up Administrators"
$users=import-csv .\Book1.csv
New-ADUser -Name "Test" -Path "OU=Connect,$($ADDomain.DistinguishedName)" -ChangePasswordAtLogon $false -Company "Connect Up"

