Function Copy-SqlLogin
{


$sourceDb = 'Cyberscope123'
$targetDb = 'CS'
$sourceServer = 'localhost'
$targetServer = 'localhost'
$sourceUser = 'domain\CSadmin'
$targetUser = 'domain\CSadmin'
 
 
#Check if the user exists in source
Get-DbaDbUser -SqlInstance $sourceServer -Database $sourceDb | 
        Where-Object {$_.Name -eq $sourceUser} |
        Select-Object name, login, createdate | ft -AutoSize
 
#Get the script for the DB user
$userScriptSource = Export-DbaUser `
                        -SqlInstance $sourceServer `
                        -Database $sourceDb `
                        -User $sourceUser `
                        -Passthru #-FilePath $outFile 
 
#Replace source user with target user name
$userScriptTarget = [Regex]::Replace(`
                         $userScriptSource, `
                         [regex]::Escape($sourceUser), `
                         $targetUser, `
                         [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
 
 
 
 
#Create the user in target
Invoke-Sqlcmd `
        -ServerInstance $targetServer `
        -Database $targetDb `
        -Query $userScriptTarget
}
