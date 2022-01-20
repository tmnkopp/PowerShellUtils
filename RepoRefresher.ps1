$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    

$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests\';  
$ex = @( "app.config", ".exe", "*.csproj" ); 
$in = @( "Selenium", "Models", "Data", "packages.config", "Selenium.DataCall.Tests" ); 
Copy-Item -Path $src* -Exclude $ex -Include $in -Destination D:\repos\xUnit-Browser-Tests -Recurse -Force  
cd D:\repos\xUnit-Browser-Tests; git add .; git commit -m ("unit tests refactor " + $m); git push;

$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
 
cd 'c:\posh'; git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push; 
cd 'C:\sql'; git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic; 
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
git add .; git commit -m ("unit tests refactor " + $m) ; git push;

cd C:\Users\tim\source\repos\Py\snippets; # git status;  
git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push;

cd C:\users\tim\source\repos\SledgeOMatic;
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
git add .; git commit -m ("compilers refactor "  + $m); git push; 
