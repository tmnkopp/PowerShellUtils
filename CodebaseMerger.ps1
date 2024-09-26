 
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database D:\dev\CyberScope\trunk\CSwebdev\database /MIR
cd D:\dev\CyberScope\trunk\CSwebdev\database; svn add --force * --auto-props --parents --depth infinity -q
 
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope  /MIR
cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope; svn add --force * --auto-props --parents --depth infinity -q

cd D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\; svn status
svn add --force * --auto-props --parents --depth infinity -q
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\Web.config;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\bin;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\obj; 
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests\bin;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests\obj;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator\bin;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator\obj;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB\bin;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB\obj;
svn rm --keep-local D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\TempUp;
cd D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\; svn status

cd D:\dev\CyberScope\trunk\CSwebdev\database\ ;  svn update;  svn status
svn ci -m "CS-9500 merge prod 7.58"

cd D:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\ ; svn update;  svn status;
svn ci -m "CS-9500 merge prod 7.58"

explorer.exe "D:\dev\CyberScope\trunk"

cd D:\dev\CyberScope\trunk\; svn status; 
svn add --force * --auto-props --parents --depth infinity -q 
svn status; 
svn ci -m "CS-9500 merge prod 7.56"

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope
svn update
svn resolved D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope
svn commit -m "CS-9500 merge prod 7.56"

  





 
 