function Invoke-DirReplacer
{ 
    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory = $true, Position = 0)] 
        [string] $to,
        [Parameter(Mandatory = $true, Position = 1)] 
        [string] $from,
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $exclude = ''
    )
    if($to -ne ''){
        dir -Path $to -Recurse | 
        Select -ExpandProperty FullName |
        Where {$_ -notmatch $exclude} | 
        Sort length -Descending |
        Remove-Item  
        $coll = dir -Path  $from -Recurse | where {$_ -notmatch $exclude}  | % {$_.FullName} 
        Copy-Item -Path  $coll -Destination $to -Recurse -Force   
    }   
} 
Invoke-DirReplacer -to 'D:\temp\to\' -from 'D:\temp\from\' -exclude '.*tempup.*|.*tempdown.*|web\.config'  

