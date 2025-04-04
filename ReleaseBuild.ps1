function ReleaseBuild
{
	[CmdletBinding()]
	param
	(   
        [Alias("s")][Parameter(Mandatory = $true, Position = 1)][string] $Source = 'C:\inetpub\wwwroot\CyberScopeBranch_Release' , 
        [Alias("d")][Parameter(Mandatory = $true, Position = 2)][string] $Dest = 'C:\inetpub\wwwroot\CyberScopeBranch',
        [Alias("b")][Parameter(Mandatory = $false,Position = 3)][string] $BackupDir = 'C:\temp\backup'  
	)  
    $windir = [Environment]::GetFolderPath("Desktop") + '\'
    $vpc = $VerbosePreference -ne [System.Management.Automation.ActionPreference]::SilentlyContinue
    if(Test-Path "$($BackupDir)"){ 
        $destpath = ($BackupDir + '\'+(Get-Date -format "yyyy-MM-dd HH.mm.ss")+'.zip')
        Compress-Archive -Path ($Dest + '\*') -DestinationPath ($destpath)
        Expand-Archive -LiteralPath $destpath -DestinationPath ($BackupDir + '')
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

RETURN ; 

xcopy C:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\Web.config  C:\temp\CyberScopeBranch\Web.config 
CD C:\temp\CyberScopeBranch
DIR


ReleaseBuild -s "C:\temp\CyberScopeBranch_Release" `
 -d "C:\temp\CyberScopeBranch" `
 -b "c:\temp\backup\"  -v 

$dir = "C:\temp\CyberScopeBranch_Release"
$latest = Get-ChildItem -Path $dir | Sort-Object LastAccessTime -Descending | Select-Object -First 1
$latest.name


 



 