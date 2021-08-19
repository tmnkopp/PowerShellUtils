$src = 'C:\inetpub\wwwroot\CyberScopeBranch_Release\'; 
$dest = 'C:\inetpub\wwwroot\CyberScopeBranch\';
$exclusions = @("web.config", $dest + "tempup*", $dest + "tempdown*");

Remove-Item $src"tempup*"  -Recurse -Force  
Remove-Item $src"tempdown*"  -Recurse -Force   
Copy-Item -Path $src*  -Exclude $exclusions -Destination $dest -Recurse -Force  


cls;
$dest = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\';
$src = 'C:\posh\';  
$inc = @("DirReplacer.ps1", "CreateRelease.ps1", "SqlRunner.ps1",  "VersionMerger.ps1", "DBUtils.ps1", "sqlconnector.ps1", "SourceControlUtils.ps1", "BackerUpper.ps1" ); 
Copy-Item -Path $src* -Include $inc -Destination $dest -Recurse -Force  

$src = 'C:\sql\';  
$inc = @( "CreateDbFromBackup.sql", "vwTableSpace.sql", "XE_Tracer.sql", "XE_Session.sql" ); 
Copy-Item -Path $src* -Include $inc -Destination $dest -Recurse -Force 
  
cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils 
svn status | Out-GridView -PassThru  |  ForEach-Object {    
    $_ -match '(.+\s{2,7})(.*)';
    $stat = $Matches[1] 
    $file = $Matches[2] 
    if($stat -match '\?'){
        svn add $file; 
    }  
}  
explorer.exe D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\  
 
cls; cd  'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\' ; svn status;   


 
