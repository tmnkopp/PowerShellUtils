cd c:\_som 
svn log  -l 5  | Out-GridView -PassThru  |  ForEach-Object {    
    Write-Host $_  
}  