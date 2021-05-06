
Get-ChildItem  -Path 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database' -Recurse -Filter *sql  | `
Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-30)) } | ` 
Where-Object { ($_.FullName -match '(\\Sprocs|\\Views|\\Functions|\\Triggers)') } | `    
Sort-Object -Property $_.LastWriteTime -de |  Out-GridView -PassThru  |  ForEach-Object  { 
    Write-Host $_.FullName
    Invoke-Sqlcmd   -InputFile $_.FullName -Database Cyberscope123  -Password $config.CSDBPASS  -Username CSAdmin 
}
 