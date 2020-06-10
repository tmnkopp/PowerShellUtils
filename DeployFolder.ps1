

$src = 'C:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'C:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("", $dest + "tempup*", $dest + "tempdown*");

# Remove-Item -Path $dest -Exclude $exclusions -Recurse -Force -WhatIf  

Get-ChildItem -Path $dest -Recurse -exclude 'web.config' | `
Select -ExpandProperty FullName | `
Where {$_ -notlike $dest + "tempup*" -and $_ -notlike $dest + "tempdown*"} | ` 
sort length -Descending | `
Remove-Item -Recurse -force  -WhatIf  

# Remove-Item -Path $root + 'C:\inetpub\wwwroot\CS2\*' -Recurse   -Force   
# Copy-Item -Path 'C:\inetpub\wwwroot\CS2_Release\*' -Exclude $exclusions  -Destination 'C:\inetpub\wwwroot\CS2\' -Recurse -Force 
  
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\Web.config' -Destination 'C:\inetpub\wwwroot\CS2\'   -Force 
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempup\' -Destination 'C:\inetpub\wwwroot\CS2\tempup\'  -Recurse   -Force  
# Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempdown\' -Destination 'C:\inetpub\wwwroot\CS2\tempdown\'  -Recurse    -Force  
 
