#Open C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.sln
explorer.exe C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code

#Open SSMS (SQL Server Management Studio)
    #-Select correct database CyberScope123
ssms.exe

#Open C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code
explorer.exe C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code
  
#SVN (SubVersion) update code
    #-Right click on Code folder
    #-Select SVN update
cd C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code
svn status

#Open C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database
explorer.exe C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database

#SVN update Database 
    #-Right click on database folder
    #-Select SVN update
    #-Drag each update into SSMS

cd C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database
svn status 

#Open CyberScope.sln in visual studio