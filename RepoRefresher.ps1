$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
cls;
$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope.Automator\';  
$ex = @( "app.config", ".exe", "*.csproj" );  
Copy-Item -Path $src* -Exclude $ex -Destination D:\repos\xUnit-Browser-Tests -Recurse -Force  
cd D:\repos\xUnit-Browser-Tests; git add .; git commit -m ("refactor base automator  " + $m); git push;  
 
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
$m = -join ((65..90) + (97..122) | Get-Random -Count 2 | % {$_});  
$src = 'D:\dev\CyberBalance\trunk\projects\CyberBalance.CS.Core\Data\';  
Copy-Item -Path $src* -Destination D:\repos\xUnit-Browser-Tests\Data -Recurse -Force  
cd D:\repos\xUnit-Browser-Tests; git add .; git commit -m ("refactor repo" + $m); git push;  
 
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
$dt = (Get-date).AddDays(-25) 
Get-ChildItem "${src}*.*" -File |? { ($_.LastWriteTime -gt $dt)  } |% { Copy-Item $_ $dest} 
cd 'D:\dev\CyberScope\CsLab\CSwebdev\code\CyberScope'; git add .; git commit -m ("unit tests refactor " + $m); git push; 
