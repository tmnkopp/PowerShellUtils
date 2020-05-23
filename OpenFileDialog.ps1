function Invoke-UdfOpenFileDialog{ 
    [CmdletBinding()] 
    Param(   
        [Parameter(Mandatory=$True,Position=0)]   
        [string]$initdir, 
        [switch]$multifile 
   )
 
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
 
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog   
    $OpenFileDialog.initialDirectory = $initdir    
 
    If ($multifile)   {     $OpenFileDialog.Multiselect = $true   }     
    $OpenFileDialog.ShowDialog() | Out-Null   
    $OpenFileDialog.filename 
}