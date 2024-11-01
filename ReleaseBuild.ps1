function ReleaseBuild
{
	[CmdletBinding()]
	param
	(   
        [Alias("s")][Parameter(Mandatory = $true, Position = 1)][string] $Source = 'C:\inetpub\wwwroot\CyberScopeBranch_Release' , 
        [Alias("d")][Parameter(Mandatory = $true, Position = 2)][string] $Dest = 'C:\inetpub\wwwroot\CyberScopeBranch',
        [Alias("b")][Parameter(Mandatory = $false,Position = 3)][string] $BackupDir = 'C:\temp\backup'  
	)  
    $vpc = $VerbosePreference -ne [System.Management.Automation.ActionPreference]::SilentlyContinue
    if(Test-Path "$($BackupDir)"){ 
        Compress-Archive -Path ($Dest + '\*') -DestinationPath ($BackupDir + '\'+(Get-Date -format "yyyy-MM-dd HH.mm.ss")+'.zip')
    } 
    if(Test-Path "$($Dest)"){
        Get-ChildItem -Path  "$($Dest)"  -Recurse |
        Where-Object FullName -notmatch '.*\\TempUp.*|.*\\TempDown.*|.*web\.config$' | 
        Remove-Item -Recurse  -Force; 
         
        robocopy "$($Source)" "$($Dest)" /E  /XF *.config `
        /XD "$($Source)\bin" "$($Source)\TempDown" "$($Source)\TempUp" 
    } 
    
    Write-Verbose $Source 
    Write-Verbose $Dest 
    Write-Verbose $BackupDir  
    if($vpc){
        ii $BackupDir  
    } 
}     
ReleaseBuild -s "C:\temp\CyberScopeBranch_Release" `
 -d "C:\temp\CyberScopeBranch" `
 -b "c:\temp\backup\"  -v 


 