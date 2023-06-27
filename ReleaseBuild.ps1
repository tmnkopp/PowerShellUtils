function ReleaseBuild
{
	[CmdletBinding()]
	param
	(   
        [Alias("s")] 
        [Parameter(Mandatory = $true, Position = 1)] 
        [string] $Source = 'C:\inetpub\wwwroot\CyberScopeBranch_Release' , 
        [Alias("d")] 
        [Parameter(Mandatory = $true, Position = 2)] 
        [string] $Dest = 'C:\inetpub\wwwroot\CyberScopeBranch',
        [Alias("t")] 
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $Temp = 'C:\temp\cs\'  
	) 
    Write-Verbose $Source 
    Write-Verbose $Dest 
    Write-Verbose $Temp  
    foreach ($d in Get-PSDrive -PSProvider FileSystem){
        Write-Verbose "Drive: $($d)"  
    } 
    if(Test-Path "$($Temp)"){
        Get-ChildItem -Path  $Temp | Remove-Item -Recurse -Force   
        robocopy /S /E  $Source  $Temp 
    }
    if(Test-Path "$($Dest)"){
        Get-ChildItem -Path  "$($Dest)"  -Recurse |
        Where-Object FullName -notmatch '.*\\TempUp.*|.*\\TempDown.*|.*web\.config$' | 
        Remove-Item -Recurse  -Force; 
         
        robocopy "$($Source)" "$($Dest)" /E  /XF *.config `
        /XD "$($Source)\bin" "$($Source)\TempDown" "$($Source)\TempUp" 
    } 
}     
# ReleaseBuild -s "C:\temp\CyberScopeBranch_Release" -d "C:\temp\CyberScopeBranch" -v

 