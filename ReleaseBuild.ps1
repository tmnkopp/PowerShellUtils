function ReleaseBuild
{
	[CmdletBinding()]
	param
	(   
        [Alias("s")] 
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $Source = 'G:\inetpub\wwwroot\CyberScopeBranch_Release' , 
        [Alias("d")] 
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $Dest = 'G:\inetpub\wwwroot\CyberScopeBranch',
        [Alias("t")] 
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $Temp = 'C:\temp'  
	)
    if( $Source -eq ''){
        $Source=($Dest + '_Release')
    }
    Write-Verbose $Source 
    Write-Verbose $Dest 
    Write-Verbose $Temp  

    Get-ChildItem -Path  $Temp | Remove-Item -Recurse -Force   
    robocopy /S /E  $Source  $Temp 
    
    Get-ChildItem -Path  $Temp -Recurse |
        Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
        Remove-Item -Recurse -Force; 
    
    Get-ChildItem -Path  $Dest -Recurse |
        Where-Object FullName -notmatch '.*TempUp.*|.*TempDown.*|.*Web\.config$' | 
        Remove-Item -Recurse  -Force; 
    
    robocopy /S /E  $Temp  $Dest
}     



Get-ChildItem -Path "D:\dev\CyberScope\temp" | Remove-Item -Recurse -Force   
robocopy /S /E D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope D:\dev\CyberScope\temp 

Get-ChildItem -Path "D:\dev\CyberScope\temp" -Recurse |
    Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
    Remove-Item -Recurse -Force; 

Get-ChildItem -Path "D:\dev\CyberScope\CsLab_Release" -Recurse |
    Where-Object FullName -notmatch '.*TempUp.*|.*TempDown.*|.*Web\.config$' | 
    Remove-Item -Recurse  -Force; 

robocopy /S /E D:\dev\CyberScope\temp D:\dev\CyberScope\CsLab_Release
 
explorer.exe "D:\dev\CyberScope\temp"


  

