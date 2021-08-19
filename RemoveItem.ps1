
cls;
dir -Path  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -notmatch '.*tempup.*|.*tempdown.*|.*StyleSheets.*|web\.config'} | 
sort length -Descending |
Write-Output

 