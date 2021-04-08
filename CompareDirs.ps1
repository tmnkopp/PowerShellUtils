 

$src = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope'
$dest = 'D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code\CyberScope'
$exc =  @("*vbproj*","*csproj*","*.dll*","*.xml*","*.cache","*.pdb","*.xsd","*.pubxml","*.txt")
$inc = @("*aspx*","*.vb*","*.ascx")

$f1 = Get-ChildItem -Exclude $exc -Include $inc  -Recurse -path $src `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/01/2021' }  
$f2 = Get-ChildItem -Exclude $exc -Include $inc  -Recurse -path $dest `
    | WHERE-OBJECT{ $_.LastWriteTime -gt '4/01/2021' } 

 
Compare-Object -ReferenceObject $f1 -DifferenceObject $f2 -Property Name, LastWriteTime, Fullname  `
    | Where-Object {$_.SideIndicator -eq "<="} `
    | Out-GridView  -PassThru  | ForEach-Object {  
        $nam = $_.FullName   
        Copy-Item -Path ("$nam")  -Destination $nam.Replace($src, $dest) -Verbose
} 

cd D:\dev\CyberScope\CyberScope-v-7-34\CSwebdev\code; dotnet build;     
 
