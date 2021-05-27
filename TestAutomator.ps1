$config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  

cd 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code';  
dotnet build;  
Get-ChildItem  -Path d:\dev\CyberScope\CyberScopeBranch\CSwebdev\database\ -Recurse -Filter *sql  | `
Where-Object { ($_.LastWriteTime -gt  (Get-date).AddDays(-5)) } | `
Where-Object { ($_.FullName -match '(DBUpdate_7.35_ED2120_2021|SolarWindNetwork)') } | `
ForEach-Object { 
    Write-Host  $_.FullName
    Invoke-Sqlcmd -Database 'Cyberscope123' -InputFile $_.FullName  -Password $config.CSDBPASS -Username CSAdmin  
}  
cd 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code';  
dotnet build; 

$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -p cyber.yaml -t SOLAR
  