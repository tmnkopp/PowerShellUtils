
$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
$src=$config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\'  
svn log  -l 5

####### CODE ######
$src = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope'  
$inc = @("*.aspx","*.vb","*.ascx","*.master", "*.css", "*.js") 
$nams = Get-ChildItem -Include $inc -Recurse -path $src `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/23/2021' -and $_.FullName -match "\."  }   
     
Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams
notepad.exe C:\temp\svnupdates.txt
cd $src 
svn commit --targets 'C:\temp\svnupdates.txt' -m"CS-8132 updated  HVA Reporting";


####### DB ######
$src = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\'
cd $src  
svn status -u  
$inc = @("*.sql") 
$nams = Get-ChildItem -Include $inc -Recurse -path $src `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/23/2021' } 
Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams    
notepad.exe 'C:\temp\svnupdates.txt'
 

svn commit --targets 'C:\temp\svnupdates.txt' -m"CS-8132 add ArtifactTypes";
 

#cd D:\dev\CyberScope\CyberScopeBranch\CSwebdev 
#svn  update 


 