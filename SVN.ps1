﻿
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
        if($stat -match 'A|M'){ } # CS-8450    CS-8412 update remove default literal tc not building 
        svn commit $file -m 'CS-8883 drop down update '; # CS-8494 EINS  CS-8614 CIO
    }    
    $nams = ''; Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''; 
    $base = (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\')
    cd $base 
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file; }  
        $nams = ($nams + $base + $file + [Environment]::NewLine);
        # svn commit $file -m ' CS-8836 create 2022 IG show hide '; #  date import - remove date logic 
    }   
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams;  notepad.exe 'C:\temp\svnupdates.txt';
 
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' # CS-8895 HVA Section 1 DB UPDATE';  
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-8890 default toggle to hide optional ';  
    svn commit --targets 'C:\temp\svnupdates.txt' -m 'CS-8889 bold Add Additional Guidance Notes ';  
    svn commit --targets 'C:\temp\svnupdates.txt' -m ' CS-8885	  create data request/response service ';  
    
    # CS-8895 HVA Section 1 DB UPDATE
    # start chrome https://dayman.cyber-balance.com/TeamCity/project/_Root?mode=builds     
    
    # CS-8889 Add Additional Guidance Notes to Each Section: FY22 Annual IG
    # CS-8865 Create Toggle to Show/Hide Optional Metrics: FY22 FISMA Annual IG
    # CS-8883 Update IPv4 Validations - EINSTEIN Config 
    # CS-8816 Modify BOD 22-01 KEV - Section 2 Grid and Validations
    # CS-8459 Browser Automator IG Config
    # CS-8816 Modify Allow Read Only Insert for batch   
    # CS-8826 CDM date import - remove date logic
    # CS-8459 Browser Automator config attribute targets 
    # CS-8459 Browser Automator 2201 Config
    # CSHELP-3211 update section 4 validation
}