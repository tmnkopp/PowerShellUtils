cd c:\_som 
svn log  -l 5  | Out-GridView -PassThru  |  ForEach-Object {    
    Write-Host $_  
}  
explorer.exe C:\Users\Tim\Documents\Backup
New-Item C:\Users\Tim\Documents\Backup\log.txt

