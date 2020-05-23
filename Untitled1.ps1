

Get-ChildItem  -Path 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\' | `
 ?{ $_.PSIsContainer } | `  
 Where { $_.FullName -notmatch 'Archive'  } | ` 
 ForEach-Object {  
     Get-ChildItem  -Path $_.FullName | ` 
     Where {  $_.LastWriteTime -gt  (Get-date).AddDays(-15) } | ` 
      ForEach-Object { 
        $src = $_.FullName 
        Write $_.FullName
     }
     
    #$hash.add('SQL' , $src)
    
 }  
 
 