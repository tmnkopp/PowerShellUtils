

Get-ChildItem -Path  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -notmatch '.*tempup.*|.*tempdown.*|.*\.config'} | 
sort length -Descending |
Write-Output

 