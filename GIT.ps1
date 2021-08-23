 
cd 'c:\posh'; git pull; git add .; git commit -m "update deploy script"; git push; 
cd 'C:\sql'; git add .; git commit -m "backup update  "; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic; 
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}) 
git add .; git commit -m "refactor yaml serializer "+$m; git push;

cd C:\Users\Tim\source\repos\Py\snippets; git status; git pull;
git add .; git commit -m "yaml unit test "; git push;

cd C:\users\tim\source\repos\SledgeOMatic;
git add .; git commit -m " added yaml unit test "; git push; 

cd C:\users\tim\source\repos\JiraPortal;
git add .; git commit -m "revise view module"; git push;  
cd C:\users\tim\source\repos\JiraCore;
git add .; git commit -m "revise unittests "; git push;   
cd C:\users\tim\source\repos\SOMData
git add .; git commit -m "added code gen assm";git push; 
cd C:\users\tim\source\repos\somuing
git add .; git commit -m "refactored "; git push; 
cd C:\users\tim\source\repos\SOM-API
git add .; git commit -m "added code gen"; git push;
 
cd 'C:\Users\Tim\source\repos\Py\snippets'
git remote set-url origin   https://github.com/tmnkopp/PythonBoiler.git
git push --set-upstream origin master
git remote -v 
git add .; git commit -m "refac main"; git push;


cd 'D:\PS'
git remote set-url origin   https://github.com/tmnkopp/PowerShellUtils.git
git push --set-upstream origin master
git remote -v
git status

cd C:\users\tim\source\repos\JiraFormatter
git add .; git commit -m "u test revise"; git push; 

cd 'c:\posh';
git status; 
git rm --cached Deploy.*
