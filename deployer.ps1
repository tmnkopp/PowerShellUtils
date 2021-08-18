cd G:\inetpub\wwwroot\database
svn status
 
Get-ChildItem  -Path 'G:\inetpub\wwwroot\database' -Recurse -Filter *sql  | `
Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-45)) } | ` 
Where-Object { ($_.FullName -notmatch '(\\Utils|\\InProgress|\\Archive)') } | `    
Sort-Object -Property $_.LastWriteTime -de |  Out-GridView -PassThru  |  ForEach-Object  { 
    Write-Host $_.FullName
    Invoke-Sqlcmd  -InputFile $_.FullName -Database Cyberscope123 -Password 'P@ssword1'  -Username CSAdmin 
}
 
explorer.exe G:\inetpub\wwwroot\CyberScopeBranch
explorer.exe G:\inetpub\wwwroot\CyberScopeBranch_Release\
explorer.exe G:\inetpub\wwwroot\database


$dest = 'G:\temp\bak\'
Remove-Item $dest*  -Recurse -Force  
$dest = 'G:\temp\bak\'
$src = 'G:\inetpub\wwwroot\CyberScopeBranch\';   
Copy-Item -LiteralPath $src -Destination $dest -Force -Recurse  

$src = 'G:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'G:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("web.config", $dest + "tempup*", $dest + "tempdown*");

Remove-Item $src"tempup*"  -Recurse -Force     
Remove-Item $src"tempdown*"  -Recurse -Force       
Copy-Item -Path $src*  -Exclude $exclusions -Destination $dest -Recurse -Force 