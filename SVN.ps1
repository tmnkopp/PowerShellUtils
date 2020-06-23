cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\ 
svn log  -l 5
cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev 
svn  update 
####### CODE ######

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\
svn status -u
svn  commit `
'' `
-m "CS-7485 updated  CIO C4 2020"
 
###### DB #######

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\
svn status -q  
svn  commit `
'DB_Update7.26_CIOQ42020.sql' `
-m 'CS-'  
 
svn --help  log 