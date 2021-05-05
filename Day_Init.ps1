Import-Module  c:\posh\DBUtils.ps1  
Import-Module  c:\posh\SourceControlUtils.ps1  
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
SVNUpdate 
# DBBackup -dbname CyberScopeLite 
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
DBUpdate -pass $config.CSDBPASS -dbname Cyberscope123
DBUpdate -pass $config.CSDBPASS -dbname CyberScopeLite


 
$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -t rtime -p timesheets.yaml   

$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -t ebil -p timesheets.yaml  

Committer -with ' dbstage ' -commitm 'CS-8132  metrics updated' # '  commit  CS-8117 updated IG5 lists' CS-8132	
Committer -with ' codestage  ' -commitm 'CS-8132  metrics updated' # 'commit  CS-8117 updated IG5 lists'

 