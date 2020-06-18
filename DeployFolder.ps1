$src = 'C:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'C:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("web.config", $dest + "tempup*", $dest + "tempdown*");

Remove-Item $src"tempup*"  -Recurse -Force  
Remove-Item $src"tempdown*"  -Recurse -Force   
Copy-Item -Path $src*  -Exclude $exclusions -Destination $dest -Recurse -Force  

 