
function SVNCommitter
{ 
    [CmdletBinding()]
        param (  
            [Alias("p")][Parameter(Mandatory = $false, Position = 0)][string] $Path,
            [Alias("m")][Parameter(Mandatory = $false, Position = 1)][string] $CommitMessage, 
            [Alias("c")][Parameter(Mandatory=$false, Position=2)][bool]$commit = $false
    ) 
    Write-Verbose ( $commit ); 
    $nams = ''; Set-Content -Path 'C:\temp\svnupdates.txt' -Value '';  

    Write-Verbose ($Path);  
    cd $Path 
    
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ;  
        if($file -notmatch '\.config|\.csv|\.user|\.local'){
            if($stat -match '\?'){  svn add $file; }  
            $nams = ($nams + $Path + $file + [Environment]::NewLine);
            Write-Verbose ($file);  
        } 
    }   
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams; 
    $updates = Get-Content -Path 'C:\temp\svnupdates.txt';
    if($updates){   
        Write-Host ( $updates | Out-String);    
    }  
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
    cd ($config.BALANCE+''); svn update; 
    cd ($config.BRANCH+'\database'); svn update ;    
    cd ($config.BRANCH+'\code'); svn update;  
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

