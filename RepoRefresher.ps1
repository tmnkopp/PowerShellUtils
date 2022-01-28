$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
cls;
$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Tests\';  
$ex = @( "app.config", ".exe", "*.csproj" ); 
$in = @( "Selenium", "Models", "Data", "packages.config", "Selenium.DataCall.Tests" ); 
Copy-Item -Path $src* -Exclude $ex -Include $in -Destination D:\repos\xUnit-Browser-Tests -Recurse -Force  
cd D:\repos\xUnit-Browser-Tests; git add .; git commit -m ("unit tests refactor " + $m); git push;  
 
cd 'c:\posh'; git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push; 
cd 'C:\sql'; git add .; git commit -m ("unit tests refactor " + $m) ; git push;
  
cd C:\users\tim\source\repos\BrowseOmatic;  
git add .; git commit -m ("unit tests refactor " + $m) ; git push;

cd C:\Users\tim\source\repos\Py\snippets; 
git pull; git add .; git commit -m ("unit tests refactor " + $m) ; git push;

cd C:\users\tim\source\repos\SledgeOMatic; 
git add .; git commit -m ("compilers refactor "  + $m); git push; 
 
$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\Scripts\dashboard\';cls;  
$dest = 'D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope\CyberScope\Scripts\dashboard\';
$dt = (Get-date).AddDays(-5) 
Get-ChildItem "${src}*.*" -File |? { ($_.LastWriteTime -gt $dt)  } |% { Copy-Item $_ $dest} 
cd 'D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope'; git add .; git commit -m ("unit tests refactor " + $m); git push; 
