 

$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope'
$dest = 'D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code\CyberScope'
$exc =  @("*.resources*","*.config*","*.out*","*.licx*","*\bin*","*\Debug*","*.dll*","*.xml*","*.cache","*.pdb","*.xsd","*.pubxml","*.txt")
# $inc = @("*aspx*","*.vb*","*.ascx","*.master")

$f1 = Get-ChildItem -Exclude $exc   -Recurse -path $src `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/05/2021' }  
$f2 = Get-ChildItem -Exclude $exc   -Recurse -path $dest `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/05/2021' } 

 
Compare-Object -ReferenceObject $f1 -DifferenceObject $f2 -Property Name, LastWriteTime, Fullname  `
    | Where-Object {$_.SideIndicator -eq "<=" -and $_.FullName  -match "\."  } `
    | Out-GridView  -PassThru  | ForEach-Object {  
        $nam = $_.FullName   
        Copy-Item -Path ("$nam")  -Destination $nam.Replace($src, $dest) -Verbose
} 

cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code; dotnet build;     
 
