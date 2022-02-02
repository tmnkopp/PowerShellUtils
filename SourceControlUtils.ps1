 
function SVNCommitter
{ 
    [CmdletBinding()]
        param (  
        [Parameter(Mandatory = $false, Position = 1)] 
        [string] $With = '  ' 
    )

    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
    cd ($config.BALANCE)
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1] ;  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file;  }     
        if($stat -match 'A|M'){ } # CS-8450    CS-8412 
        svn commit $file -m 'CS-8614 control update data grid  '; # CS-8494 EINS  CS-8614 CIO
    }   
    cd (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\database\')
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file;  }      
        svn commit $file -m 'CS-8686 updates for perms '; 
    }   
    cd (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\code\')
    svn status |  Out-GridView -PassThru | ForEach-Object   {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1] ;  $file = $Matches[2] ; svn add $file; # CS-8450    CS-8412  CS-8459 Selenium Browser Automator Refactor	
        if($stat -match '\?'){  svn add $file;  }      
        svn commit $file -m ( 'CS-8686 updates for perms  ' ); 
    }   
    # start chrome https://dayman.cyber-balance.com/TeamCity/project/_Root?mode=builds    
 
}             
function SVNUpdate 
{ 
    [CmdletBinding()]
        param (  
            [Alias("b")]
            [Parameter(Mandatory = $false, Position = 0)] 
            [bool] $BuildCode = $false 
    ) 
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
    cd ($config.CSDIR+':\dev\CyberBalance\trunk\projects'); svn update; 
    cd ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database'); svn update ;    
    cd ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code'); svn update; 
    if( $BuildCode ){
        $msbuild = 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe'
        & $msbuild -v:q  -clp:ErrorsOnly  -p:WarningLevel=0 ; cls;   
    } 
}
 
function Committer(){ 
    [CmdletBinding()]
     param (  
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $commitm = 'CS-8132 updated 19 metric' ,
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $with = ' ' ,        
        [Parameter(Mandatory = $false, Position = 0)] 
        [string] $fromdate = (Get-Date -date ((Get-Date).AddDays(-1)) -format "MM/dd/yyyy")
    )
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json 
    $inc = @("*.aspx","*.vb","*.ascx","*.master", "*.css", "*.js", "*.sql", "*.vbproj") 
    $exc = @("Archive") 
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''
    ####### DB ###### 
    $src = ($config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\database\') 
    if( $with -match '.*db.*'){ 
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
    $src = $config.CSDIR+':\dev\CyberScope\CyberScopeBranch\CSwebdev\code\CyberScope' 
    if( $with -match '.*code.*'){ 
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