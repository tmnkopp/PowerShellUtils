﻿
function Committer(){ 
    [CmdletBinding()]
     param (  
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $commitm = 'CS-8132 updated metrics' ,
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $with = ' ' ,        
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $fromdate = (Get-Date -date ((Get-Date).AddDays(-2)) -format "MM/dd/yyyy")
    )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
    $inc = @("*.aspx","*.vb","*.ascx","*.master", "*.css", "*.js", "*.sql") 
    $exc = @("Archive") 
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''
    ####### DB ###### 
    if( $with -match '.*db.*'){
        $src = ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\') 
        cd $src  
        $fs = Get-ChildItem -Include $inc -Recurse -path $src `
            | WHERE-OBJECT{ $_.LastWriteTime -gt $fromdate } 
        Set-Content -Path 'C:\temp\svnupdates.txt' -Value $fs 
    }   
    if( $with -match '.*commit.*'){
        cd $src 
        svn commit --targets 'C:\temp\svnupdates.txt' -m $commitm;
    } 
    ####### CODE ###### 
    if( $with -match '.*code.*'){
        $src = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' 
        $nams = Get-ChildItem -Include $inc -Recurse -path $src `
            | WHERE-OBJECT{ $_.LastWriteTime -gt $fromdate -and $_.FullName -match "\."  }    
        Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams
    } 
    if( $with -match '.*commit.*'){
        cd $src 
        svn commit --targets 'C:\temp\svnupdates.txt' -m $commitm; svn status;
    } 
    ####### STAGE ######
    if( $with -match '.*stage.*'){
        notepad.exe 'C:\temp\svnupdates.txt'; cls; svn status ;
    }   
} 
Committer -with '  codestage '