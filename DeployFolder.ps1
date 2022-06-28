
$rex = '\.ps1'
$movefrom = 'D:\dev\CyberScope\trunk\CSwebdev\database\Utils\'
$moveto = 'D:\temp\cs'    
Get-ChildItem $moveto | 
    Where {$_.FullName -notmatch $rex} |   
    Remove-item -Recurse -Force
Get-ChildItem $movefrom |  
    Where {$_.FullName -notmatch $rex} | 
    Copy-Item -Destination $moveto -Recurse -Force
 




cls;
$dest = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\Utils\';
$src = 'C:\posh\';  
$inc = @( "DBUpdater.ps1", "SourceControlUtils.ps1", "ReleaseBuild.ps1" ); 
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