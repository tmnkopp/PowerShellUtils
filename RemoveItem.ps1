

Get-ChildItem -Path  'C:\temp' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -notmatch '.*keep.*|.*temp\.txt'} |
sort length -Descending |
Write-Output

 