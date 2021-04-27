Import-Module  c:\posh\DBUtils.ps1  
Import-Module  c:\posh\SourceControlUtils.ps1 
Committer -with ' dbstage '
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
SVNUpdate 
#  DBBackup -dbname CyberScopeLite 
DBUpdate -pass $config.CSDBPASS -dbname Cyberscope123
DBUpdate -pass $config.CSDBPASS -dbname CyberScopeLite

$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -t rtime -p timesheets.yaml   

 