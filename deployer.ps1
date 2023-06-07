Get-ChildItem -Path  C:\temp\CyberScopeBranch  -Recurse |
Where-Object FullName -notmatch '.*TempUp.*|.*TempDown.*|.*\.config$' | 
Remove-Item -Recurse  -Force; 
 
robocopy C:\temp\CyberScopeBranch_Release C:\temp\CyberScopeBranch /E  /XF *.config `
/XD C:\temp\CyberScopeBranch_Release\bin C:\temp\CyberScopeBranch_Release\TempDown C:\temp\CyberScopeBranch_Release\TempUp 

explorer.exe C:\temp\CyberScopeBranch 
cd C:\temp\CyberScopeBranch 
mkdir TempDown
mkdir TempUp
echo web.config