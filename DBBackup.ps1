#
 

 Get-SqlDatabase -ServerInstance localhost | Out-GridView -PassThru | Backup-SqlDatabase -Incremental

 Get-ChildItem (Get-Item sqlserver:\sql\localhost\default\).BackupDirectory | ` 
      ForEach-Object {  
        Write $_.FullName
     }

