 
function Invoke-ExtractObjectFromScript {
    [CmdletBinding()] 
    param(   
        [string] $Path = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Views\aa_temp.sql'
    )
    $sql = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "") 
    $sql | Select-String '(DROP\s*[PROCEDURE|VIEW|TRIGGER|FUNCTION]+)\s*([A-Za-z0-9\-\\_]+)' -AllMatches | Select -First 1 |  `
    % {$_.matches.groups[2].value}` 
   
}
Invoke-ExtractObjectFromScript -Path 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Views\aa_temp.sql'



function Get-FileGrid{
    $FileCollection = New-Object System.Collections.ArrayList  
    $pathToDbScripts = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'
    $rs = Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
 
    Get-ChildItem  -Path $pathToDbScripts -Recurse -Filter *sql  | `
    Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-30)) } | ` 
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
    $FileCollection  | Out-GridView -PassThru  
} 



 