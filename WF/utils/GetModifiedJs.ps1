Get-ChildItem -Force -Recurse -File -Path "D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\Scripts\"  `
| Where-Object { $_.LastWriteTime.Date -gt (Get-Date).AddDays(-60).Date -or $_.CreationTime.Date -gt (Get-Date).AddDays(-60).Date  } `
| Sort LastWriteTime -Descending `
| Select-Object FullName | Format-Table -Wrap 