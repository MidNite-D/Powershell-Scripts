#$Userinfo=import-csv "c:\users\ataylor\desktop\users.csv" #----Path to CSV File
$domain = [ADSI] "LDAP://UKWAR-DC01:389/ou=test and training accounts,ou=user accounts,ou=uki,ou=offices,dc=ibahealth,dc=local"#--Put OU Here



$newuser=$domain.create("user","cn=powershelltest")#----container name
#Account Tab
$newuser.put("userPrincipalName","pshell@ibahealth.local")#----logonname
$newuser.put("sAMaccountname","pshell")#----logonname pre 2000
#General Tab
$newuser.put("givenName","Test")#----First Name
$newuser.put("sn","User")#----Surname
$newuser.put("DisplayName","Test User")#----Display Name#
$newuser.put("description","test powershell creation")#----Description
$newuser.put("mail","test@test.com")#----email

#Security
$newUser.SetInfo()#--Apply
#$newUser.psbase.InvokeSet('AccountDisabled', $false)#----Account enable
$newUser.SetInfo()#--Apply
$newUser.SetPassword("L0renz0!")#---- Password


$objUser = [ADSI]"LDAP://UKWAR-DC01:389/CN=powershelltest,ou=test and training accounts,ou=user accounts,ou=uki,ou=offices,dc=ibahealth,dc=local"
$objUser.put(”userAccountControl”, 66080)
$objUser.SetInfo()

