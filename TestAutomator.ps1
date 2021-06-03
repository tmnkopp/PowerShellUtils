$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  

cd 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code';  
dotnet build;  

$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -p cyber.yaml -t AGSOL
  