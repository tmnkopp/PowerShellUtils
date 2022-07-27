$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
cd 'c:\posh'; git pull; git add .; git commit -m ("Refactor debug fixes #"  + $m); git push; 
cd 'C:\sql'; git add .; git commit -m ("Refactor DB Bak fixes #"  + $m); git push; 
cd D:\repos\BrowseOmatic; git pull;  
git add .; git commit -m ("Compile proj unit test fixes #" + $m) ; git push; 
cd C:\Users\Tim\source\repos\Py\snippets; # git status;   
git pull; git add .; git commit -m ("Compile codegen fixes #"  + $m); git push;  
cd D:\repos\SledgeOMatic;  git pull;  
git add .; git commit -m ("compilers refactor "  + $m); git push;  


cd D:\repos\somuing;
git add .; git commit -m "refactor post compile   "; git push;  
cd D:\repos\SOM-API; 
git add .; git commit -m "refactor post compile  "; git push; 
cd D:\repos\SOMData;
git add .; git commit -m "refactor update to 4.1"; git push; 
 
cd D:\repos\JiraPortal;
git add .; git commit -m "revise view module"; git push;  
cd D:\repos\JiraCore;
git add .; git commit -m "revise unittests "; git push;   
cd D:\repos\JiraFormatter; 
git add .; git commit -m "u test revise"; git push;  
  
cd 'c:\posh';
git status; 
git rm --cached Deploy.*
 
 