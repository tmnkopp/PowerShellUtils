Import-Module  c:\posh\DBUtils.ps1  
Import-Module  c:\posh\SourceControlUtils.ps1  
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
SVNUpdate
# DBBackup  
DBUpdate -pass $config.CSDBPASS

# $exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
# & $exe cmd -t ebil -p timesheets.yaml

# $exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')  
# & $exe cmd -t rtime -p timesheets.yaml 

  