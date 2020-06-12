$src = 'C:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'C:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("web.config", $dest + "tempup*", $dest + "tempdown*");

Remove-Item $src"tempup*"  -Recurse -Force  
Remove-Item $src"tempdown*"  -Recurse -Force   
Copy-Item -Path $src*  -Exclude $exclusions -Destination $dest -Recurse -Force  


# Remove-Item -Path $root + 'C:\inetpub\wwwroot\CS2\*' -Recurse   -Force   
# Copy-Item -Path 'C:\inetpub\wwwroot\CS2_Release\*' -Exclude $exclusions  -Destination 'C:\inetpub\wwwroot\CS2\' -Recurse -Force 
  
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\Web.config' -Destination 'C:\inetpub\wwwroot\CS2\'   -Force 
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempup\' -Destination 'C:\inetpub\wwwroot\CS2\tempup\'  -Recurse   -Force  
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempdown\' -Destination 'C:\inetpub\wwwroot\CS2\tempdown\'  -Recurse    -Force  
 
