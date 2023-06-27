 
robocopy /S /E C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database C:\dev\CyberScope\trunk\CSwebdev\database /MIR
cd C:\dev\CyberScope\trunk\CSwebdev\database; svn add --force * --auto-props --parents --depth infinity -q
 
robocopy /S /E C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Automator C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator  /MIR
cd C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator; svn add --force * --auto-props --parents --depth infinity -q
 
robocopy /S /E C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests  /MIR
cd C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests; svn add --force * --auto-props --parents --depth infinity -q

robocopy /S /E C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests.VB C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB  /MIR
cd C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB; svn add --force * --auto-props --parents --depth infinity -q

robocopy /S /E C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope  /MIR
cd C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope; svn add --force * --auto-props --parents --depth infinity -q

cd C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\; svn status
svn add --force * --auto-props --parents --depth infinity -q
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\bin;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\obj; 
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests\bin;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests\obj;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator\bin;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Automator\obj;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB\bin;
svn rm --keep-local C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope.Tests.VB\obj;

cd C:\dev\CyberScope\trunk\CSwebdev\code\CyberScope\; 
svn ci -m "CS-9500 merge prod 7.54"

explorer.exe "C:\dev\CyberScope\trunk"

cd C:\dev\CyberScope\trunk\; svn status; 
svn add --force * --auto-props --parents --depth infinity -q 
svn status; 



 
 