
function SVNCommitter
{ 
    [CmdletBinding()]
        param (  
            [Alias("m")] 
            [Parameter(Mandatory = $false, Position = 0)] 
            [string] $CommitMessage = ''  
    ) 
    $nams = ''; Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''; 
    $config = (Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json  
    cd ($config.BALANCE)
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file; }  
        $nams = ($nams + $base + $file + [Environment]::NewLine); 
    }     
    $base = (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\')
    cd $base 
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file; }  
        $nams = ($nams + $base + $file + [Environment]::NewLine); 
    }   
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams; 
    $updates = Get-Content -Path 'C:\temp\svnupdates.txt';
    if($updates){   
        Write-Verbose ( $updates | Out-String);   
    }
    # svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-9157 update css ';   #  CS-8894 1802 frmval update CS-8901 BOD1802 Update Sections 4,5 CS-8895 1b prefix update
    # CS-9157 request response service   # CSHELP-3404 
    # CS-9208 Create BOD 18-02 HVA Agency Reporting Status Custom Query
    # CS-8459 Browser Automator IG Config       
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

