function DBUpdate 
{  
  [CmdletBinding()]
   param ( 
    [Parameter(Mandatory = $false, Position = 0)] 
    [int] $UpdateFromDays = 90  
   )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
    [string] $pathToDbScripts = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'
    
    $FileCollection = New-Object System.Collections.ArrayList   
    $config  = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json   
    Write-Host $config.CONNSTR -match 'SQL'
    $pass=$config.CSDBPASS

    if($config.CONNSTR -match '.*SQL.*'){
        $rs = Invoke-Sqlcmd  -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;" -ConnectionString $config.CONNSTR
    }else{
        $rs = Invoke-Sqlcmd  -Database 'Cyberscope123'  -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
    } 
    Get-ChildItem  -Path $pathToDbScripts -Recurse -Filter *sql  | `
    Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-$UpdateFromDays)) } | `
    Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress)') } | `
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
        if($config.CONNSTR -match '.*SQL.*'){
            Invoke-Sqlcmd -InputFile $_.Script  -ConnectionString $config.CONNSTR
        }else{
            Invoke-Sqlcmd  -Database 'Cyberscope123' -InputFile $_.Script  -Password $pass  -Username CSAdmin  
        } 
    }    
} 
function Invoke-ExtractObjectFromScript {
    [CmdletBinding()] 
    param(   
        [string] $Path = ''
    )
    $sql = (Get-Content $Path).Replace("[dbo].", "").Replace("dbo.", "").Replace("[", "").Replace("]", "") 
    $sql | Select-String ".*DROP\s{1,}(\w{2,255})\s{1,}([A-Za-z0-9\\_]{3,})" -AllMatches | Select -First 1 |  `
    % {$_.matches.groups[2].value}`  
}   