 

$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope'
$dest = 'D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code\CyberScope'
$exc =  @("*.resources*","*.config*","*.out*","*.licx*","*\bin*","*\Debug*","*.dll*","*.xml*","*.cache","*.pdb","*.xsd","*.pubxml","*.txt")
# $inc = @("*aspx*","*.vb*","*.ascx","*.master")

$f1 = Get-ChildItem -Exclude $exc   -Recurse -path $src `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/05/2021' }  
$f2 = Get-ChildItem -Exclude $exc   -Recurse -path $dest `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/05/2021' } 

$nams = ''
Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams
Compare-Object -ReferenceObject $f1 -DifferenceObject $f2 -Property Name, LastWriteTime, Fullname  `
    | Where-Object {$_.SideIndicator -eq "<=" -and $_.FullName  -match "\."  } `
    | Sort-Object -Property LastWriteTime -de  | Out-GridView  -PassThru | ForEach-Object {  
        $nam = $_.FullName   
        Copy-Item -Path ("$nam")  -Destination $nam.Replace($src, $dest) -Verbose
        $nams += $_.FullName.Replace("D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\", "") +  "`n"
} 

Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams   
cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code; 
dotnet build;   
cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code; 
svn commit --targets 'C:\temp\svnupdates.txt' -m"CS-8057 CyberScope-v-7-34 Update Branch" ;
 
 
