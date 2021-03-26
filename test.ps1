cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\ 
svn log  -l 5  | Out-GridView -PassThru  |  ForEach-Object {    
    Write-Host $_  
}  