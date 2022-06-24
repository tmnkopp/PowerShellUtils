Get-ChildItem -Path "D:\dev\CyberScope\temp" | Remove-Item -Recurse -Force   
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope D:\dev\CyberScope\temp 

Get-ChildItem -Path "D:\dev\CyberScope\temp" -Recurse |
    Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
    Remove-Item -Recurse -Force; 

Get-ChildItem -Path "D:\dev\CyberScope\CsLab_Release" -Recurse |
    Where-Object FullName -notmatch '.*TempUp.*|.*TempDown.*|.*Web\.config$' | 
    Remove-Item -Recurse  -Force; 

robocopy /S /E D:\dev\CyberScope\temp D:\dev\CyberScope\CsLab_Release
 
explorer.exe "D:\dev\CyberScope\temp"


  

