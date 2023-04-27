$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
cd 'c:\posh'; git pull; git add .; git commit -m ("Refactor debug fixes #"  + $m); git push;  
cd C:\Users\timko\source\repos\PythonBoiler;
git add .; git commit -m ("refactor struct : " + $m); git push;   
   
cd 'C:\sql'; git add .; git commit -m ("Refactor DB Bak fixes #"  + $m); git push; 
cd c:\repos\BrowseOmatic; git pull;  
git add .; git commit -m ("Compile proj unit test fixes #" + $m) ; git push;  
cd c:\repos\SledgeOMatic;  git pull;  
git add .; git commit -m ("compilers refactor "  + $m); git push;  
cd C:\Users\Tim\source\repos\Py\snippets; # git status;   
git pull; git add .; git commit -m ("Compile codegen fixes #"  + $m); git push;  

code D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope\CyberScope\scripts\;
git pull;

cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code
msbuild CyberScope.sln
 
cd D:\repos\somuing;
git add .; git commit -m "refactor post compile   "; git push;  
cd D:\repos\SOM-API; 
git add .; git commit -m "refactor post compile  "; git push; 
cd D:\repos\SOMData;
git add .; git commit -m "refactor update to 4.1"; git push; 
 

cd 'c:\posh';
git status; 
git rm --cached Deploy.*
 
 