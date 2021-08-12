
cls; 
$p=$PSCommandPath
$p -match '(.*\\).*\.ps1'
Write-Host  $Matches[1] ; 
 