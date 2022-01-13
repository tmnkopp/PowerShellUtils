 
cd 'c:\posh'; git pull; git add .; git commit -m "refac svn update"; git push; 
cd 'C:\sql'; git add .; git commit -m "refac date calc db update  "; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic; 
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
git add .; git commit -m ("refactor unit tests " + $m) ; git push;

cd C:\Users\Tim\source\repos\Py\snippets; # git status;  
git pull; git add .; git commit -m "val app init commit"; git push;

cd C:\users\tim\source\repos\SledgeOMatic;
git add .; git commit -m " update unit test "; git push; 

cd C:\users\tim\source\repos\somuing
git add .; git commit -m "refactor post compile replacer "; git push;  
cd C:\users\tim\source\repos\SOM-API; 
git add .; git commit -m "refactor post compile replacer"; git push; 
cd C:\users\tim\source\repos\SOMData
git add .; git commit -m "refactor update to 3.1";git push; 
 
cd C:\users\tim\source\repos\JiraPortal;
git add .; git commit -m "revise view module"; git push;  
cd C:\users\tim\source\repos\JiraCore;
git add .; git commit -m "revise unittests "; git push;   
cd C:\users\tim\source\repos\JiraFormatter
git add .; git commit -m "u test revise"; git push;  
  
cd 'c:\posh';
git status; 
git rm --cached Deploy.*
 
 