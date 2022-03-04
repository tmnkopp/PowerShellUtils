function Invoke-VersionMerger(){ 
    [CmdletBinding()]
    param (  
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $from = 'D:\dev\CyberScope\CyberScope-v-7-40\CSwebdev\' ,
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $to = 'D:\dev\CyberScope\trunk\CSwebdev\' ,
        [Parameter(Mandatory = $false, Position = 2)] 
        [string] $temp = 'D:\dev\CyberScope\temp\' ,
        [Parameter(Mandatory = $false, Position = 3)] 
        [string] $with = ''
    ) 
    if( $with -match '.*exec.*' )
    {
        if( Test-Path -Path ($to + "\code\CyberScope\web.config*") )
        {
           Remove-item ( $temp + "*" ) -recurse -force 

           Copy-Item -Path ($to + "\code\CyberScope\web.config*" ) -Destination ($temp) 
           Copy-Item -Path ($to + "\code\CyberScope\My Project\PublishProfiles\FolderProfile.pubxml" ) -Destination ($temp)
         
           Remove-item  $to  -recurse -force

           Copy-Item   -Path ($from) -Destination  $to  -recurse  -force 
           Copy-Item   -Path ($temp  + "web.config*") -Destination (  $to  + '\code\CyberScope\' ) -recurse  -force  
           Copy-Item   -Path ($temp  + "FolderProfile.pubxml") -Destination ( $to  + '\code\CyberScope\My Project\PublishProfiles\') -recurse  -force 
       } 
    } 
    if($with -match '.*inspect.*'){
        explorer.exe $to
    }  
    if($with -match '.*merge.*'){
        cd D:\dev\CyberScope\trunk\;
        svn add --force * --auto-props --parents --depth infinity -q
        # svn ci -m 'CS-8754 Merge Trunk'; 
        svn status; 
    }  
}   
 Invoke-VersionMerger -With 'merge'   