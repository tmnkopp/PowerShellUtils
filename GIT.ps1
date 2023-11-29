$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_}); 
cd 'c:\posh'; git pull; git add .; git commit -m ("Refactor debug fixes #"  + $m); git push;  
cd C:\Users\timko\source\repos\PythonBoiler;
git add .; git commit -m ("refactor jra provider : " + $m); git push;   

robocopy /S /E C:\Users\timko\source\repos\PythonBoiler\CodeGenerators C:\dev\CodeGen\pom
cd C:\dev\CodeGen\pom
Remove-Item * -Recurse -Include config.*
Remove-Item  cache\*  -Recurse -Force
Remove-Item  out\*  -Recurse -Force 
svn add --force * --auto-props --parents --depth infinity -q
svn commit -m ' ' 

robocopy /S /E C:\Users\timko\source\repos\SledgeOmatic C:\dev\CodeGen\som
cd C:\dev\CodeGen\som ;  
Remove-Item  SledgeOmatic\appsettings.json  -Recurse -Force 
Remove-Item  SledgeOmatic\som.cache  -Recurse -Force   
Remove-Item  SledgeOMatic\bin  -Recurse -Force  
Remove-Item  SledgeOMatic\obj  -Recurse -Force  
Remove-Item  C:\dev\CodeGen\som\.vs  -Recurse -Force   
Remove-Item  C:\dev\CodeGen\som\.git -Recurse -Force 
cd C:\dev\CodeGen\som ; svn cleanup; 
svn add --force * --auto-props --parents --depth infinity -q 
svn commit -m ' ' 

$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
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
Copy-Item -Path $src* -Exclude $ex -Destination C:\Users\timko\source\repos\SeleniumTestAutomator -Recurse -Force  
cd C:\Users\timko\source\repos\SeleniumTestAutomator; git add .; git commit -m ("refactor test automator  " + $m); git push;  
 
 
cd 'c:\posh'; git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push; 
cd 'C:\sql'; git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic;  
git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
 
$src = 'c:\posh\';  
$reg = "DBUpdater|ReleaseBuild|_move_release" 
Get-ChildItem $src -File -Recurse |? { ($_.FullName -match $reg)  } |% {Copy-Item $_.FullName ('C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\posh\'+$_.Name)}   
cd C:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\posh;  
svn commit -m "CS updated db utils "
cd y:\posh
dir
 
 
  

