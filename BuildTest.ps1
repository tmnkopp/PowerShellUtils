cd 'D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code';   
dotnet build --configuration Debug;
$exe = [System.Environment]::GetEnvironmentVariable('bom', 'User')   
& $exe cmd -t 1b -p cyber.yaml
