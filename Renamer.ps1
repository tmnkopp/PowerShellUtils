 $fs = Get-ChildItem 'D:\documents\REF\PS\PluralSight - PowerShell and Regular Expressions\*' -Recurse
 
 $fs | foreach-object  { 

    $SourcePath = $_.FullName
    $DestinationPath = $_.Fullname.Replace("--- [ FreeCourseWeb.com ] ---","")
    
    if($SourcePath -like '*.mp4'){
  
        Write-Host $DestinationPath
        Move-item –literalpath $SourcePath –destination $DestinationPath -Force
        #Remove-Item $SourcePath   
    }

  }

 
   
 