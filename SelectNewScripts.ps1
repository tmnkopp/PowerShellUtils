$rs = Invoke-Sqlcmd  -Database Cyberscope123 -Query "SELECT NAME, CREATE_DATE FROM sys.all_objects WHERE CREATE_DATE > DATEADD( d, -120 , GETDATE()) ;"
 
$rs | WHERE{ $_.Name -eq 'AddNewHVA' -and $_.CREATE_DATE -lt (Get-Date) } 
      Write-Host $_.CREATE_DATE
      
 

 
 
