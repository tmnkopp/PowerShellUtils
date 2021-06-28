$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -t rtime -p timesheets.yaml  

Stop-process -Name BOM -Force 
Get-Process | Where {$_.ProcessName -Like "BOM"} | Format-Table  
Get-Process | Where {$_.ProcessName -Like "*chrome*"} | Format-Table  

stop-process -ProcessName chromedriver.* -Force
Get-Process | Format-Table -View priority