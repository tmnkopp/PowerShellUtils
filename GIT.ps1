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



$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
cls;
$src = 'c:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Automator\';  
$ex = @( "app.config", ".exe", "*.csproj" );  
Copy-Item -Path $src* -Exclude $ex -Destination c:\repos\xUnit-Browser-Tests -Recurse -Force  
cd c:\repos\xUnit-Browser-Tests; git add .; git commit -m ("refactor test automator  " + $m); git push;  
 
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
$src = 'c:\dev\CyberBalance\trunk\projects\CyberBalance.CS.Core\Data\';  
Copy-Item -Path $src* -Destination c:\repos\xUnit-Browser-Tests\Data -Recurse -Force  
cd c:\repos\xUnit-Browser-Tests; git add .; git commit -m ("refactor repo" + $m); git push;  
 
cd 'c:\posh'; git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push; 
cd 'C:\sql'; git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic;  
git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
 
$src = 'c:\posh\'; 
$dest = 'y:\posh\';
$reg = "DBUpdater|ReleaseBuild|_move_release"
Get-ChildItem $src -File -Recurse |? { ($_.FullName -match $reg)  } |% {Copy-Item $_.FullName ($dest+$_.Name)} 
Get-ChildItem $src -File -Recurse |? { ($_.FullName -match $reg)  } |% {Copy-Item $_.FullName ('C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\posh\'+$_.Name)}   
cd C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\posh;  
svn commit -m "CS updated db utils "
cd y:\posh
dir
 
 
  

