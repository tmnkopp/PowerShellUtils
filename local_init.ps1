$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
$pathToDbScripts = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'
$UpdateFromDays = 30      
$FileCollection = New-Object System.Collections.ArrayList    

$rs = Invoke-Sqlcmd  -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;" -ConnectionString $config.CONNSTR
 
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
    Invoke-Sqlcmd -InputFile $_.Script  -ConnectionString $config.CONNSTR
}   