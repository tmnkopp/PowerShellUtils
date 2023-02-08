﻿robocopy /S /E G:\inetpub\wwwroot\CyberScopeTrunk_Release G:\temp ; 

Remove-Item G:\temp\*  -Recurse  -Force ; 

Get-ChildItem -Path "G:\temp" -Recurse |
    Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
    Remove-Item -Recurse -Force ; 

robocopy /S /E G:\temp G:\inetpub\wwwroot\CyberScopeTrunk ; 

# # # 
#robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev D:\dev\CyberScope\trunk\CSwebdev

robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database D:\dev\CyberScope\trunk\CSwebdev\database
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Automator D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests.VB D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB
explorer.exe "D:\dev\CyberScope\trunk"

cd D:\dev\CyberScope\trunk\; svn status; 
svn add --force * --auto-props --parents --depth infinity -q
# svn ci -m 'CS-8754 Merge Trunk'; 
svn status; 
 