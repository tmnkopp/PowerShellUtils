 
cd 'c:\posh'; git pull; git add .; git commit -m "update dbupdater"; git push; 
cd 'C:\sql'; git add .; git commit -m "backup update  "; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic; 
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}) 
git add .; git commit -m ("refactor serializer " + $m) ; git push;

cd C:\Users\Tim\source\repos\Py\snippets; git status; git pull;
git add .; git commit -m "code gen for xunit init "; git push;

cd C:\users\tim\source\repos\SledgeOMatic;
git add .; git commit -m " update yaml unit test "; git push; 

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
 

$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests\';  
$ex = @( "app.config", ".exe", "*.csproj" ); 
$in = @( "Selenium", "Models", "packages.config" ); 
Copy-Item -Path $src* -Exclude $ex -Include $in -Destination D:\repos\xUnit-Browser-Tests -Recurse -Force  
cd D:\repos\xUnit-Browser-Tests
git add .; git commit -m "refactor config"; git push;


cd C:\users\tim\source\repos\JiraFormatter
git add .; git commit -m "u test revise"; git push; 

cd 'c:\posh';
git status; 
git rm --cached Deploy.*
