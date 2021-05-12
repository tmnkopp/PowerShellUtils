

Get-ChildItem -Path  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -notmatch '.*tempup.*|.*tempdown.*|.*\.config'} |
# Where {$_ -match '.*EINSTEIN.*|.*\.config'} |
sort length -Descending |
Write-Output

 