
explorer.exe D:\Backup\
cd D:\Backup\
New-Item 'D:\Backup\CyberScope\' -ItemType "directory" 
New-Item 'D:\Backup\CyberScope\tempdown' -ItemType "directory" 
New-Item 'D:\Backup\CyberScope\tempup' -ItemType "directory" 
New-Item 'D:\Backup\CyberScope\web.config' -ItemType "file" 

cd D:\Backup\

Get-ChildItem -Path  'D:\Backup\CyberScope\' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -notmatch '.*tempup.*|.*tempdown.*|.*\.config'} |
# Where {$_ -match '.*EINSTEIN.*|.*\.config'} |
sort length -Descending |
Remove-Item

explorer.exe D:\Backup\CyberScope