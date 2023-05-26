$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
cd 'c:\posh'; git pull; git add .; git commit -m ("Refactor debug fixes #"  + $m); git push;  
cd C:\Users\timko\source\repos\PythonBoiler;
git add .; git commit -m ("refactor issue provider : " + $m); git push;   

robocopy /S /E C:\Users\timko\source\repos\PythonBoiler\CodeGenerators C:\dev\CodeGen\pom
cd C:\dev\CodeGen\pom
Remove-Item * -Recurse -Include config.*
Remove-Item  cache\*  -Recurse -Force
Remove-Item  out\*  -Recurse -Force 
svn add --force * --auto-props --parents --depth infinity -q
svn commit -m ' ' 

 
cd C:\Users\timko\source\repos\BrowseOmatic; git pull;  
git add .; git commit -m ("Compile proj unit test fixes #" + $m) ; git push;  
cd C:\Users\timko\source\repos\SledgeOMatic;  git pull;  
git add .; git commit -m ("compilers refactor "  + $m); git push;  
cd C:\Users\Tim\source\repos\Py\snippets; # git status;   
git pull; git add .; git commit -m ("Compile codegen fixes #"  + $m); git push;  

code D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope\CyberScope\scripts\;
git pull;

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code
msbuild CyberScope.sln
 
cd 'c:\posh';
git status; 
git rm --cached Deploy.*
 
  

