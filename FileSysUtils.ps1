
Get-ChildItem G:\* | Rename-Item -NewName { $_.Name -replace '\.720p','' } 
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