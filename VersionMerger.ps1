cls; 
$movefrom = 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev'
$moveto = 'D:\dev\CyberScope\CyberScope-v-7-35-1\CSwebdev'   
  
Copy-Item  -Path ($movefrom + "*") -Destination (  $moveto ) -recurse  -force

$temp = "D:\dev\CyberScope\temp\"   
Remove-item ( $temp + "*" ) -recurse -force

Remove-item ( $temp + "*" ) -recurse -force  
Copy-Item -Path ($moveto + "\code\CyberScope\web.config*" ) -Destination ($temp) 
Copy-Item -Path ($moveto + "\code\CyberScope\My Project\PublishProfiles\FolderProfile.pubxml" ) -Destination ($temp) 
  
$HasFiles = Test-Path -Path $movefrom* 
if( $HasFiles ) {
    Remove-item ( $moveto + "*" ) -recurse -force
    Copy-Item   -Path ($movefrom + "*") -Destination (  $moveto ) -recurse  -force 
    Copy-Item   -Path ($temp + "web.config*") -Destination (  $moveto + '\code\CyberScope\' ) -recurse  -force  
    Copy-Item   -Path ($temp + "FolderProfile.pubxml") -Destination ( $moveto + '\code\CyberScope\My Project\PublishProfiles\') -recurse  -force  
}
 