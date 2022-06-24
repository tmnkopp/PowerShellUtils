robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev D:\dev\CyberScope\trunk\CSwebdev

Get-ChildItem -Path "D:\dev\CyberScope\temp" -Recurse |
    Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
    Remove-Item -Recurse -Force;  

robocopy /S /E D:\dev\CyberScope\temp D:\dev\CyberScope\trunk
 
explorer.exe "D:\dev\CyberScope\trunk"

        cd D:\dev\CyberScope\trunk\; svn status; 
        svn add --force * --auto-props --parents --depth infinity -q
        # svn ci -m 'CS-8754 Merge Trunk'; 
        svn status; 
 