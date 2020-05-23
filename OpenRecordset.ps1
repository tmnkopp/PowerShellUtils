$rs = Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
[psobject] $myssint = New-Object psobject
$rs | WHERE{  $_.CREATE_DATE -lt (Get-Date) } | ForEach-Object{
     
      Write-Host $_.CREATE_DATE
      
} 

 
 
