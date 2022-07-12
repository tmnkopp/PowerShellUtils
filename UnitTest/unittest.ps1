Get-ChildItem  -Path 'D:\dev\CyberScope\trunk\CSwebdev\database' -Recurse -Filter *sql  | `
Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-2)) } | ` 
Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
Sort-Object -Property $_.LastWriteTime -de |ForEach-Object  { #   Out-GridView -PassThru  |  
    $ff = $_.FullName -replace 'G:\\inetpub\\wwwroot\\database', '' 
    $o =  ($o + '|' + $_.Name) 
    # Copy-Item -LiteralPath $_.FullName -Destination ($to + 'scripts\' + $ff)  -Recurse -Force 
} 
Write-Output $o 

 