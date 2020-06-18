cd D:\dev\CyberBalance\trunk\projects\
svn status -u
svn log -l 4

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\
svn status -u
svn  commit '' -m "CS-7485 updated  CIO C4 2020"
 
cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\
svn status -q  
svn  commit 'DB_Update7.26_CIOQ42020.sql' -m "CS-7485 updated  CIO C4 2020"



svn --help  status

 



