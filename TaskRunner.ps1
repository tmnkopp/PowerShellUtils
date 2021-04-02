Import-Module  d:\ps\DBUtils.ps1  
Import-Module  d:\ps\SourceControlUtils.ps1  
$config = (Get-Content "d:\ps\config.json" -Raw) | ConvertFrom-Json 
SVNUpdate
DBBackup  
DBUpdate -pass $config.CSDBPASS

# $exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')  
# & $exe cmd -t rtime -p timesheets.yaml

# $exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')  
# & $exe cmd -t csdev -p cyber.yaml

  