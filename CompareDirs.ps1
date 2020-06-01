$exc =  @("*vbproj*","*csproj*","*.dll*","*.xml*","*.cache","*.pdb","*.xsd","*.pubxml","*.txt")
$inc = @("*aspx*","*.vb*","*.ascx")

$f1 = Get-ChildItem -Exclude $exc -Include $inc   -Recurse -path D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope | WHERE-OBJECT{ $_.LastWriteTime -gt '5/15/2020' }
$f2 = Get-ChildItem -Exclude $exc -Include $inc   -Recurse -path D:\dev\CyberScope\25\CSwebdev\code\CyberScope | WHERE-OBJECT{ $_.LastWriteTime -gt '5/15/2020' }

Compare-Object -ReferenceObject $f1 -DifferenceObject $f2 -Property Name,   LastWriteTime 

 

Get-ChildItem -Exclude $exc  -Recurse -path D:\dev\CyberScope\25\CSwebdev\* | `
WHERE-OBJECT{ $_.LastWriteTime -gt '5/15/2020' }
