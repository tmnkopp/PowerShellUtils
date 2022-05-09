

 
Get-ChildItem -Path "D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope\CyberScope\"  -Recurse  | 
    Where-Object{$_.FullName -notmatch '.*TempUp.*|.*TempDown.*|.*Debug.*|.*obj.*|.*bin.*|.*Web\.config$'}  |  
    Copy-Item -Destination "D:\dev\CyberScope\CsLab_Release\"  -Recurse  -Container -WhatIf
    

$sourceDir = 'D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope\CyberScope\'
$targetDir = 'D:\dev\CyberScope\CsLab_Release\'

 

cls;
dir -Path  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\Scripts\' -Recurse |
Select -ExpandProperty FullName |
Where {$_ -match '.*kendo.*|.*CustomControls.*'} | 
Sort-Object -Property CreationTime |
Write-Output






Get-ChildItem -Force -Recurse -File -Path "D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\Scripts\"  `
| Where-Object { $_.LastWriteTime.Date -gt (Get-Date).AddDays(-60).Date -or $_.CreationTime.Date -gt (Get-Date).AddDays(-60).Date  } `
| Sort LastWriteTime -Descending `
| Select-Object FullName | Format-Table -Wrap 
 