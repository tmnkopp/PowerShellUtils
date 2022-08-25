function ReleaseBuild
{
	[CmdletBinding()]
	param
	(   
        [Alias("s")] 
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $Source = 'C:\inetpub\wwwroot\CyberScopeBranch_Release' , 
        [Alias("d")] 
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $Dest = 'C:\inetpub\wwwroot\CyberScopeBranch',
        [Alias("t")] 
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $Temp = 'C:\temp\cs\'  
	)
    if( $Source -eq ''){
        $Source=($Dest + '_Release')
    }
    Write-Verbose $Source 
    Write-Verbose $Dest 
    Write-Verbose $Temp  
    
    Write-Debug 'Copy source to temp?'  
    Get-ChildItem -Path  $Temp | Remove-Item -Recurse -Force   
    robocopy /S /E  $Source  $Temp 
    
    Get-ChildItem -Path  $Temp -Recurse |
        Where-Object FullName -match '.*\\TempUp.*|.*\\TempDown.*|.*\\bin.*|.*\\obj.*|.*Web\.config$' |
        Remove-Item -Recurse -Force; 

    Write-Debug 'Copy to Dest?' 
    Get-ChildItem -Path  $Dest -Recurse |
        Where-Object FullName -notmatch '.*TempUp.*|.*TempDown.*|.*Web\.config$' | 
        Remove-Item -Recurse  -Force; 
    
    robocopy /S /E  $Temp  $Dest
}     



  

