$exclusions = @("web.config")
 
Remove-Item -Path 'C:\inetpub\wwwroot\CS2\*' -Recurse   -Force   
Copy-Item -Path 'C:\inetpub\wwwroot\CS2_Release\*' -Exclude $exclusions  -Destination 'C:\inetpub\wwwroot\CS2\' -Recurse -Force 
  
Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\WEB.config' -Destination 'C:\inetpub\wwwroot\CS2\'   -Force 
Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempup\' -Destination 'C:\inetpub\wwwroot\CS2\tempup\'  -Recurse   -Force  
Copy-Item -Path 'C:\inetpub\wwwroot\CyberScopeBranch\tempdown\' -Destination 'C:\inetpub\wwwroot\CS2\tempdown\'  -Recurse    -Force  

[string] $replaceScript = '<script src="~/Scripts/server.js"></script>';
[string] $replace = Get-Content 'C:\inetpub\wwwroot\CS2_Release\HeaderOnly.Master'  | Select-String '(<title>.*</title>)' -AllMatches | Select -First 1 | `
    % {$_.matches.groups[0].value}` 
(Get-Content 'C:\inetpub\wwwroot\CS2\HeaderOnly.Master').Replace( $replace , "`n$replace`n$replaceScript`n") | Set-Content 'C:\inetpub\wwwroot\CS2\HeaderOnly.Master' 

#<title>DHS Cyberscope</title>
