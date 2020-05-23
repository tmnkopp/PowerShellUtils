 function Invoke-UpdateDB 
 {  
  [CmdletBinding()]
   param ( 
    [Parameter(Mandatory = $true, Position = 0)] 
    [int] $UpdateFromDays = 5 
   )

    [bool] $doBackup = $false 
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
            ScriptUpdated = $_.LastWriteTime;  
            DBUpdated = $rec.CREATE_DATE ;  
            DateDiff= $rec.CREATE_DATE -lt  $_.LastWriteTime  ;
        }
        [void]$FileCollection.Add($scriptitem)  
        $dbobject =''
    } 
    $FileCollection  | Out-GridView -PassThru  |  ForEach-Object {    
        Write-Host $_.Script 
        Invoke-Sqlcmd  -Database $dbname -InputFile $_.Script   -Password P@ssword1  -Username CSAdmin  
     }  
} 
function Invoke-ExtractObjectFromScript {
    [CmdletBinding()] 
    param(   
        [string] $Path = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Views\aa_temp.sql'
    )
    $sql = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "") 
    $sql | Select-String '(DROP [PROCEDURE|VIEW|TRIGGER|FUNCTION]+ )([A-Za-z0-9\-\\_]+)' -AllMatches | `
    % {$_.matches.groups[2].value}` 
   
}

Invoke-UpdateDB -UpdateFromDays 35