 
function DBBackup 
{ 
    [CmdletBinding()] 
    param (  
      [Parameter(Mandatory = $false )] 
      [string] $dbname = 'Cyberscope123'
    )  
    Write-Host 'DBBackup: ' $dbname   
    Get-SqlDatabase -ServerInstance localhost -NAME $dbname | Backup-SqlDatabase -Incremental    
}
function PassResetter{
    [CmdletBinding()]
    param (  
     [Parameter(Mandatory = $true, Position = 0)] 
     [string] $pass = '' 
    )
    $sql = "UPDATE aspnet_Membership 
            SET IsLockedOut = 0
            , IsApproved = 1
            , Password = 'HRnRWpAftHn6V+MWljtLDDJdNXQ='
            , PasswordSalt = '5FyxBJd7FpU1Elu0xjyVnw==' 
            WHERE UserId <> '80CA7CC1-C0A1-44A8-9DF9-912F52C7FE51'"
    
    Invoke-Sqlcmd -Database Cyberscope123 -Query $sql -Password $pass -Username CSAdmin  

} 
  
function DBUpdate 
{  
  [CmdletBinding()]
   param ( 
    [Parameter(Mandatory = $false, Position = 0)] 
    [int] $UpdateFromDays = 30 ,
    [Parameter(Mandatory = $true, Position = 1)] 
    [string] $pass = '' ,  
    [Parameter(Mandatory = $false, Position = 2)] 
    [string] $dbname = 'Cyberscope123' 
   )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
    [string] $pathToDbScripts = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'
     
    $FileCollection = New-Object System.Collections.ArrayList   
    $rs = Invoke-Sqlcmd  -Database $dbname  -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
 
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
    $FileCollection | Sort-Object -Property ScriptUpdated -de | Out-GridView -PassThru  |  ForEach-Object {    
        Write-Host $_.Script 
        Invoke-Sqlcmd  -Database $dbname -InputFile $_.Script  -Password $pass  -Username CSAdmin  
    }   

} 
function Invoke-ExtractObjectFromScript {
    [CmdletBinding()] 
    param(   
        [string] $Path = ''
    )
    $sql = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "") 
    $sql | Select-String '(DROP\s*[PROCEDURE|VIEW|TRIGGER|FUNCTION]+)\s*([A-Za-z0-9\-\\_]+)' -AllMatches | Select -First 1 |  `
    % {$_.matches.groups[2].value}` 
   
} 

 

  