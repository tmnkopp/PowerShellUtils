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
        svn commit $file -m ' CS-9019 null sub in integer '; # CS-8494 EINS  CS-8614 CIO
    }    
    $nams = ''; Set-Content -Path 'C:\temp\svnupdates.txt' -Value ''; 
    $base = (((Get-Content "c:\posh\config.json" -Raw) | ConvertFrom-Json).BRANCH   + '\CSwebdev\')
    cd $base 
    svn status | Out-GridView -PassThru | ForEach-Object {    
        $_ -match '(.+\s{2,7})(.*)';
        $stat = $Matches[1];  $file = $Matches[2] ; 
        if($stat -match '\?'){  svn add $file; }  
        $nams = ($nams + $base + $file + [Environment]::NewLine); 
    }   
    Set-Content -Path 'C:\temp\svnupdates.txt' -Value $nams;  notepad.exe 'C:\temp\svnupdates.txt'; 
    # CS-8958 Update export columns  CS-8988 7c Update CS-9019 null sub in integer
    # CS-9022 Text update section 1
    svn commit --targets 'C:\temp\svnupdates.txt' -m 'CS-8648 enable q3 non-eo frm val  ';   #  CS-8894 1802 frmval update CS-8901 BOD1802 Update Sections 4,5 CS-8895 1b prefix update
    # CS-8951 CIOq3 prevent rerun of the post question add form  
    # CS-8892 HVA1802 batch query     
    # CS-8901 BOD1802 Annual 1A Db Dependancy Update-   
    # CS-8459 Browser Automator IG Config       
}