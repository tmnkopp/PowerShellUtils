explorer.exe D:\Backup\
explorer.exe C:\SQL\

$dt = get-date -format yyyy-MM-ddTHH-mm-ss
$dt
$sql = " 
     BACKUP DATABASE [Cyberscope123] 
     TO DISK = N'D:\Backup\CyberScope.bak' 
     WITH DIFFERENTIAL, NOFORMAT, NOINIT
    , NAME = N'BK-CS  " + $dt +  "'
    , SKIP, NOREWIND, NOUNLOAD,  STATS = 10 
"
Import-Module  c:\posh\DBUtils.ps1   
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
Invoke-Sqlcmd -Database 'Cyberscope123' -Password $config.CSDBPASS -Username CSAdmin -Query $sql
explorer.exe D:\Backup\

# Invoke-Sqlcmd -Database 'Cyberscope123' -InputFile 'C:\sql\Backup.sql'  -Password $config.CSDBPASS -Username CSAdmin 






