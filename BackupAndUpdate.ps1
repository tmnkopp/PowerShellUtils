﻿cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev 
svn  status
svn    log -l 5 -v
svn  update 
svn  status
##svn --help log


Invoke-UpdateDB -UpdateFromDays 5
 
 function Invoke-UpdateDB 
 {  
  [CmdletBinding()]
   param ( 
    [Parameter(Mandatory = $true, Position = 0)] 
    [int] $UpdateFromDays = 5 
   )

    [bool] $doBackup = $true
    [string] $dbname = 'Cyberscope123'
    [string] $pathToDbScripts = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'

     if([bool]$dobackup){
        Get-SqlDatabase -ServerInstance localhost -NAME $dbname | Backup-SqlDatabase -Incremental   
     }  
    $FileCollection = New-Object System.Collections.ArrayList   
    $rs = Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
 
    Get-ChildItem  -Path $pathToDbScripts -Recurse -Filter *sql  | `
    Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-$UpdateFromDays)) } | ` 
    Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
    ForEach-Object { 
        $dbobject = Invoke-ExtractObjectFromScript -Path $_.FullName
        $rec = ($rs  | Where-Object {$_.NAME -eq $dbobject})
        $scriptitem = New-Object PsObject -Property @{        
            Script = $_.FullName;   
            DBObject = $dbobject;    
            ScriptUpdated = [DateTime]$_.LastWriteTime;  
            DBUpdated =  $rec.CREATE_DATE ;  
            DateDiff= $rec.CREATE_DATE -lt  $_.LastWriteTime  ;
        }
        [void]$FileCollection.Add($scriptitem)  
        $dbobject =''
    } 
    $FileCollection  | Out-GridView -PassThru  |  ForEach-Object {    
        Write-Host $_.Script 
        Invoke-Sqlcmd  -Database $dbname -InputFile $_.Script   -Password P@ssword1  -Username CSAdmin  
     }  
      Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT TOP 50   NAME, CONVERT(VARCHAR(20), CREATE_DATE) UPDATED FROM sys.all_objects  ORDER BY CREATE_DATE DESC"  | Out-GridView

} 
function Invoke-ExtractObjectFromScript {
    [CmdletBinding()] 
    param(   
        [string] $Path = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Views\aa_temp.sql'
    )
    $sql = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "") 
    $sql | Select-String '(DROP\s*[PROCEDURE|VIEW|TRIGGER|FUNCTION]+)\s*([A-Za-z0-9\-\\_]+)' -AllMatches | Select -First 1 |  `
    % {$_.matches.groups[2].value}` 
   
}
