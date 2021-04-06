Import-Module  d:\ps\DBUtils.ps1  
Import-Module  d:\ps\SourceControlUtils.ps1  
$config = (Get-Content "d:\ps\config.json" -Raw) | ConvertFrom-Json 
SVNUpdate 
# DBBackup -dbname CSLITE 
DBUpdate -pass $config.CSDBPASS -dbname CSLITE
DBUpdate -pass $config.CSDBPASS -dbname Cyberscope123
 