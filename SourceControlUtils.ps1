 
  
function SVNUpdate 
{ 
    [CmdletBinding()]
        param (  
            [Alias("b")]
            [Parameter(Mandatory = $false, Position = 0)] 
            [bool] $BuildCode = $false 
    ) 
   
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json    
    cd ($config.BALANCE+''); svn update; 
    cd ($config.BRANCH+'\CSwebdev\database'); svn update ;    
    cd ($config.BRANCH+'\CSwebdev\code'); svn update; 
    
    if( $BuildCode ){
        try
        {  
            $paths=[Environment]::GetEnvironmentVariable('PATH', 'Machine') -split ';' 
            $msbuild = '';
            foreach($p in $paths){
                if($p -match 'MSBUILD'){
                    $msbuild = ($p+'\MSBuild.exe');
                } 
            }
            & $msbuild -v:q  -clp:ErrorsOnly  -p:WarningLevel=0 ;    
        }
        catch
        { 
            Write-Host "msbuild fail " + $config.MSBUILD
        } 
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
    # DB
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
    # CODE
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
    # STAGE
    if( $with -match '.*stage.*'){
        notepad.exe 'C:\temp\svnupdates.txt'; cls; svn status ;
    }   
} 