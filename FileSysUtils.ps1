
Get-ChildItem G:\* | Rename-Item -NewName { $_.Name -replace '\.720p','' } 
Copy-Item -path D:\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope\HVA\2021\ -Destination C:\temp\backup 
function FileDialog{ 
    [CmdletBinding()] 
    Param(   
        [Parameter(Mandatory=$True,Position=0)]   
        [string] $initdir 
   )
     $initdir 
    
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null 
    $OpenFileDialog = New-Object System.Windows.Forms.FileDialog   
    $OpenFileDialog.initialDirectory = $initdir     
    $OpenFileDialog.ShowDialog() | Out-Null   
    $OpenFileDialog.filename 
} 
FileDialog -initdir 'c:\bom'

explorer.exe c:\temp