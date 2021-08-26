 
cls;
$dest = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\';
$src = 'C:\posh\';  
$inc = @( "DBUpdater.ps1" ); 
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