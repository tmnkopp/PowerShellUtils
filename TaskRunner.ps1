Import-MOdule  d:\ps\DBUtils.ps1  

$config = (Get-Content "config.json" -Raw) | ConvertFrom-Json 
SVNUpdate
DBBackup  
DBUpdate -pass $config.CSDBPASS

$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')  
& $exe cmd -t rtime -p timesheets.yaml

  