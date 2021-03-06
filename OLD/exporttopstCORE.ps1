## Get-Mailbox | Add-MailboxPermission -User "<YourUserName>" -AccessRights FullAccess

### export-mailbox -identity jdglover -pstfolderpath \\ukban-pststore\archive

cls
$USER=read-host "Your Credentials (DOMAIN\USERNAME) "
$TARGET=read-host "Target Mailbox (Alias) "
Get-Mailbox $TARGET| Add-MailboxPermission -User $USER -AccessRights FullAccess

export-mailbox -identity $TARGET -pstfolderpath \\ukban-pststore\archive

