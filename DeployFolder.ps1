$src = 'C:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'C:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("web.config", $dest + "tempup*", $dest + "tempdown*");

Remove-Item $src"tempup*"  -Recurse -Force  
Remove-Item $src"tempdown*"  -Recurse -Force   
Copy-Item -Path $src*  -Exclude $exclusions -Destination $dest -Recurse -Force  


cls;
$dest = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\';
$src = 'C:\posh\';  
$inc = @( "DBUtils.ps1", "sqlconnector.ps1", "SourceControlUtils.ps1" ); 
Copy-Item -Path $src* -Include $inc -Destination $dest -Recurse -Force  

$src = 'C:\sql\';  
$inc = @( "CreateDbFromBackup.sql", "vwTableSpace.sql", "XE_Tracer.sql", "XE_Session.sql" ); 
Copy-Item -Path $src* -Include $inc -Destination $dest -Recurse -Force  

cd $dest
svn add *.sql;  
explorer.exe $dest; 

cls; cd  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\' ; svn status;   


 
