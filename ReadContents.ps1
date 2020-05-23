[string] $pathToDbScripts = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\' 
[int] $scriptLastUpdateDays = 1 
$FileCollection = New-Object System.Collections.ArrayList  
$rs = Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
 

Get-ChildItem  -Path $pathToDbScripts |  ?{ $_.PSIsContainer } | `  
Where { $_.FullName -notmatch 'Archive'  } | ` 
ForEach-Object {  
    Get-ChildItem  -Path $_.FullName | ` 
    Where {  $_.LastWriteTime -gt  (Get-date).AddDays(-$scriptLastUpdateDays) } | ` 
    ForEach-Object { 
        $dt = $_.LastWriteTime
        $sql = (Get-Content $_.FullName).Replace("[dbo].", "")
        $sql | Select-String '(CREATE \w*) \[(\w*)\]' -AllMatches | foreach {$_.Matches} | 
        Foreach-Object {
            $nam = $_.Groups[2].Value 
            $rec = $rs | WHERE{ $_.Name -eq $nam -and $_.CREATE_DATE -lt $dt }  
            Write-Host  $rec.CREATE_DATE   $dt 
        }  
    }  
}